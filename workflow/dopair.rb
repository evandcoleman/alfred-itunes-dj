require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require "./bundle/bundler/setup"
require "alfred"
require './dacpclient/lib/dacpclient'
require 'socket'

pin = ARGV[0].split("")
client = DACPClient.new "Alfred", 'localhost', 3689
client.login pin
puts "Pairing Successful!"