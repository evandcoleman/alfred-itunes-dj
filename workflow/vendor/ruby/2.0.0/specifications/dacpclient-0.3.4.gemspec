# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "dacpclient"
  s.version = "0.3.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jurriaan Pruis"]
  s.date = "2014-12-07"
  s.description = "A DACP (iTunes Remote protocol) client"
  s.email = ["email@jurriaanpruis.nl"]
  s.executables = ["dacpclient"]
  s.extra_rdoc_files = ["README.md", "LICENSE"]
  s.files = ["bin/dacpclient", "README.md", "LICENSE"]
  s.homepage = "https://github.com/jurriaan/ruby-dacpclient"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
  s.rubygems_version = "2.0.14.1"
  s.summary = "A DACP (iTunes Remote protocol) client"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<faraday>, ["~> 0.9.0"])
      s.add_runtime_dependency(%q<dnssd>, ["~> 2.0"])
      s.add_runtime_dependency(%q<plist>, ["~> 3.1.0"])
      s.add_runtime_dependency(%q<dmapparser>, ["~> 0.2.0"])
      s.add_runtime_dependency(%q<thor>, ["~> 0.19.1"])
      s.add_runtime_dependency(%q<fuzzy_match>, ["~> 2.1.0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<redcarpet>, [">= 0"])
      s.add_development_dependency(%q<github-markup>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rubocop>, ["~> 0.27.1"])
      s.add_development_dependency(%q<minitest>, ["~> 5.4.0"])
    else
      s.add_dependency(%q<faraday>, ["~> 0.9.0"])
      s.add_dependency(%q<dnssd>, ["~> 2.0"])
      s.add_dependency(%q<plist>, ["~> 3.1.0"])
      s.add_dependency(%q<dmapparser>, ["~> 0.2.0"])
      s.add_dependency(%q<thor>, ["~> 0.19.1"])
      s.add_dependency(%q<fuzzy_match>, ["~> 2.1.0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<redcarpet>, [">= 0"])
      s.add_dependency(%q<github-markup>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rubocop>, ["~> 0.27.1"])
      s.add_dependency(%q<minitest>, ["~> 5.4.0"])
    end
  else
    s.add_dependency(%q<faraday>, ["~> 0.9.0"])
    s.add_dependency(%q<dnssd>, ["~> 2.0"])
    s.add_dependency(%q<plist>, ["~> 3.1.0"])
    s.add_dependency(%q<dmapparser>, ["~> 0.2.0"])
    s.add_dependency(%q<thor>, ["~> 0.19.1"])
    s.add_dependency(%q<fuzzy_match>, ["~> 2.1.0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<redcarpet>, [">= 0"])
    s.add_dependency(%q<github-markup>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rubocop>, ["~> 0.27.1"])
    s.add_dependency(%q<minitest>, ["~> 5.4.0"])
  end
end
