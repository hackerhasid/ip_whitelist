# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ip_whitelist/version"

Gem::Specification.new do |s|
  s.name        = "ip_whitelist"
  s.version     = Ip::Whitelist::VERSION
  s.authors     = ["Dan Sharp"]
  s.email       = ["drsharp@sharpdesigns.com"]
  s.homepage    = ""
  s.summary     = %q{Ip Whitelist middleware}
  s.description = %q{Rack middleware to quickly add ip whitelisting to your app}
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
