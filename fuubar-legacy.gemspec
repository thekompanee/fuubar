# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "fuubar-legacy"
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nicholas Evans", "Jeff Kreeftmeijer"]
  s.email       = ["jeff@kreeftmeijer.nl"]
  s.homepage    = "https://github.com/jeffkreeftmeijer/fuubar"
  s.summary     = %q{the instafailing RSpec progress bar formatter}
  s.description = %q{the instafailing RSpec progress bar formatter}

  s.rubyforge_project = "fuubar"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency('rspec', ["~> 1.3"])
  s.add_runtime_dependency('chalofa_ruby-progressbar', ["~> 0.0.9"])
  s.add_runtime_dependency('rspec-instafail', ["~> 0.1.4"])
  s.add_development_dependency('rake')
end
