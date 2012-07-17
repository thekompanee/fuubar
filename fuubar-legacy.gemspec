# coding: utf-8

Gem::Specification.new do |gem|
  gem.name        = 'fuubar-legacy'
  gem.version     = '0.0.3'
  gem.platform    = Gem::Platform::RUBY
  gem.authors     = ['Nicholas Evans', 'Jeff Kreeftmeijer']
  gem.email       = ['jeff@kreeftmeijer.nl']
  gem.homepage    = 'https://github.com/jeffkreeftmeijer/fuubar'
  gem.summary     = %q{The instafailing RSpec progress bar formatter}
  gem.description = %q{The instafailing RSpec progress bar formatter for rspec-1}

  gem.rubyforge_project = 'fuubar'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_runtime_dependency     'rspec', '~> 1.3'
  gem.add_runtime_dependency     'progressbar', '~> 0.11'
  gem.add_runtime_dependency     'rspec-instafail', '~> 0.1.4'
  gem.add_development_dependency 'rake'
end
