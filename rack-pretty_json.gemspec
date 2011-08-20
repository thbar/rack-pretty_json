# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rack/pretty_json/version"

Gem::Specification.new do |s|
  s.name        = "rack-pretty_json"
  s.version     = Rack::PrettyJSON::VERSION
  s.authors     = ["Thibaut Barrère", "Jérémy Lecour", "vzmind"]
  s.email       = ["thibaut.barrere@gmail.com", "jeremy.lecour@gmail.com", "vzmind@gmail.com"]
  s.homepage    = "https://github.com/thbar/rack-pretty_json"
  s.summary     = %q{Pretty print the JSON if the user-agent is a bowser}
  s.description = %q{If the requested resource is a JSON and the user agent is a browser, the response body is reformated for a better human readable format of the JSON (line breaks, indents, …).}

  s.rubyforge_project = ""

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency 'rack', '>=1.0.0'

  # specify any dependencies here; for example:
  s.add_development_dependency "shoulda"
  # s.add_runtime_dependency "rest-client"
end
