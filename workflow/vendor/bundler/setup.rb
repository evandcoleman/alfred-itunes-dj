require 'rbconfig'
# ruby 1.8.7 doesn't define RUBY_ENGINE
ruby_engine = defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'
ruby_version = RbConfig::CONFIG["ruby_version"]
path = File.expand_path('..', __FILE__)
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/fuzzy_match-2.1.0/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/builder-3.2.2/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/gyoku-1.3.1/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/moneta-0.8.0/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/nori-2.6.0/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/plist-3.1.0/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/terminal-notifier-1.7.1/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/alfred-workflow-2.0.5/lib"
$:.unshift "#{path}/"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/dmapparser-0.2.0/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/dnssd-2.0.1/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/multipart-post-2.0.0/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/faraday-0.9.2/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/thor-0.19.1/lib"
$:.unshift "#{path}/../#{ruby_engine}/#{ruby_version}/gems/dacpclient-0.3.4/lib"
