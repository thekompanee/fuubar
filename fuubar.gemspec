# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name                  = 'fuubar'

  s.version               = '2.0.0'

  s.authors               = ['Nicholas Evans', 'Jeff Kreeftmeijer', 'jfelchner']
  s.email                 = ['jeff@kreeftmeijer.nl']
  s.homepage              = 'https://github.com/jeffkreeftmeijer/fuubar'

  s.license               = 'MIT'
  s.summary               = 'the instafailing RSpec progress bar formatter'
  s.description           = 'the instafailing RSpec progress bar formatter'

  s.rdoc_options          = ['--charset', 'UTF-8']
  s.extra_rdoc_files      = %w[README.md LICENSE]

  s.rdoc_options          = ['--charset', 'UTF-8']
  s.extra_rdoc_files      = %w[README.md LICENSE]

  # Manifest
  s.files                 = Dir.glob("lib/**/*")
  s.test_files            = Dir.glob("{test,spec,features}/**/*")
  s.executables           = Dir.glob("bin/*").map{ |f| File.basename(f) }
  s.require_paths         = ['lib']

  s.add_dependency              'rspec',              '~> 3.0', '<= 3.5.0.beta1'
  s.add_dependency              'ruby-progressbar',   '~> 1.4'
end
