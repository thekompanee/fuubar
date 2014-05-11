# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.rubygems_version      = '1.3.5'

  s.name                  = 'fuubar'
  s.rubyforge_project     = 'fuubar'

  s.version               = '1.3.3'
  s.platform              = Gem::Platform::RUBY

  s.authors               = ['Nicholas Evans', 'Jeff Kreeftmeijer', 'jfelchner']
  s.email                 = ['jeff@kreeftmeijer.nl']
  s.date                  = Time.now
  s.homepage              = 'https://github.com/jeffkreeftmeijer/fuubar'

  s.summary               = 'the instafailing RSpec progress bar formatter'
  s.description           = 'the instafailing RSpec progress bar formatter'

  s.rdoc_options          = ['--charset', 'UTF-8']
  s.extra_rdoc_files      = %w[README.md LICENSE]

  #= Manifest =#
  s.files                 = Dir.glob("lib/**/*")
  s.test_files            = Dir.glob("{test,spec,features}/**/*")
  s.executables           = Dir.glob("bin/*").map{ |f| File.basename(f) }
  s.require_paths         = ['lib']

  s.add_dependency              'rspec',              ['>= 2.14.0', '< 3.1.0']
  s.add_dependency              'ruby-progressbar',   '~> 1.4'
end
