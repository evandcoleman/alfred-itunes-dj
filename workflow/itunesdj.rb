require_relative 'vendor/bundler/setup'
require 'dacpclient'
require 'yaml'
require 'fileutils'

class ITunesDJ
  def initialize(*)
    @config = {}
    @config['client_name'] ||= "Alfred iTunes DJ"
    @config['host'] ||= 'localhost'
    @config['known_services'] ||= []
    load_config

    if @config['guid'].nil? || @config['guid'] !~ /^[A-F0-9]{16}$/
      guid = Digest::SHA2.hexdigest(@config['client_name'])[0..15].upcase
      @config['guid'] = guid
      save_config
    end
  end

  def is_paired?
    @config['known_services'].length > 0
  end

  def pair(pin)
    pairserver = DACPClient::PairingServer.new(@config['client_name'], @config['guid'])
    pairserver.pin = pin
    database = pairserver.start
    @config['known_services'] << database.name
    save_config
  end

  def login
    browser = DACPClient::Browser.new

    database = nil

    3.times do
      browser.browse
      database = browser.services.find do |service|
        @config['known_services'].include? service.name
      end
      break if database
      sleep 0.5
    end

    @client = DACPClient::Client.new(@config['client_name'], database.host, database.port)
    @client.guid = @config['guid']
    
    @client.hsgid = @config['hsgid']
    if @client.hsgid.nil?
      @client.pair_and_login
    else
      @client.login
    end
    @login = true

    return if @client.host == @config['host']

    @config['host'] = @client.host
    save_config
  end

  def search(query)
    @client.search(query)
  end

  def artwork(song)
    art = @client.artwork song.item_id, 100, 100
    
    if art.length > 0
      filename = sanitize_filename("alfred-itunes-dj-#{song.artist}-#{song.album}")
      path = "/tmp/#{filename}.png"
      
      if !File.exist?(path)
        file = File.open(path, "w")
        file.puts(art)
      end

      return path
    end

    return nil
  end

  def queue(id)
    @client.queue(id)
  end

  def config_dir
    path = "#{ENV['HOME']}/Library/Application Support/Alfred 3/Workflow Data/net.evancoleman.alfred-up-next"
    unless File.exist?(path)
      FileUtils.mkdir_p(path)
    end
    path
  end

  def config_file
    File.join(config_dir, 'config.yml')
  end

  def load_config
    FileUtils.mkdir_p(config_dir)
    if File.exist? config_file
      data = YAML.load_file(config_file)
      @config.merge!(data) if data.is_a?(Hash)
    else
      save_config
    end
  end

  def clean_config
    @config['known_services'].delete('')
    @config['known_services'].uniq!
  end

  def save_config
    clean_config
    File.open(File.join(config_dir, 'config.yml'), 'w') do |out|
      YAML.dump(@config, out)
    end
  end

  def sanitize_filename(filename)
    # Split the name when finding a period which is preceded by some
    # character, and is followed by some character other than a period,
    # if there is no following period that is followed by something
    # other than a period (yeah, confusing, I know)
    fn = filename.split /(?<=.)\.(?=[^.])(?!.*\.[^.])/m

    # We now have one or two parts (depending on whether we could find
    # a suitable period). For each of these parts, replace any unwanted
    # sequence of characters with an underscore
    fn.map! { |s| s.gsub /[^a-z0-9\-]+/i, '_' }

    # Finally, join the parts with a period and return the result
    return fn.join '.'
  end
end
