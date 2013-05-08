#!/usr/bin/env ruby
# encoding: utf-8

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require_relative "./bundle/bundler/setup"
require "alfred"
require_relative './dacpclient/lib/dacpclient'
require 'socket'

Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback
  
  pin = ARGV[0].split("")
  client = DACPClient.new "Alfred", 'localhost', 3689
 
  if pin.count == 4 and client.is_paired == false
	fb.add_item({
	  :uid      => "",
	  :title    => "Pair Alfred With iTunes",
	  :subtitle => "Enter pin #{ARGV[0]} in iTunes",
	  :arg      => "#{ARGV[0]}"
	})
  end

  puts fb.to_alfred
end



