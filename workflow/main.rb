#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require "./bundle/bundler/setup"
require "alfred"
require './lib/dacpclient'
require 'socket'

Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback
  
  client = DACPClient.new "Alfred", 'localhost', 3689
  client.login
  databases = client.databases
  db = databases.mlcl[0].miid
  containers = client.playlists db
  library = containers.mlcl[0].miid
  query = ARGV.join(" ")
  
  results = client.search db, library, query
  
  results.mlcl.each do |song|
	#artwork isn't working right, i'll just wait for the ability to use remote images as the icon and pass in the URL directly
	art = nil
	begin
	  #art = client.artwork db, song.miid, 128, 128
	end
	icon = {:type => "default", :name => "icon.png"}
	if art != nil
	  id = song.miid
	  file = File.open("/tmp/alfred-up-next-#{id}.png", "w")
	  file.puts(art)
	  icon[:name] = file.path
	end
	
	fb.add_item({
		:uid      => "#{song.minm} - #{song.asar}",
		:title    => "#{song.minm} - #{song.asar}",
		:subtitle => "#{song.asal}",
		:icon     => icon,
		:arg      => "#{song.miid} #{song.minm}"
	})
  end
  puts fb.to_alfred
end



