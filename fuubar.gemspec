# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'fuubar'
  spec.version       = '2.0.0'
  spec.authors       = ['Nicholas Evans', 'Jeff Kreeftmeijer', 'jfelchner']
  spec.email         = '["jeff@kreeftmeijer.nl"]'
  spec.summary       = %q{the instafailing RSpec progress bar formatter}
  spec.description   = %q{the instafailing RSpec progress bar formatter}
  spec.homepage      = 'https://github.com/jeffkreeftmeijer/fuubar'
  spec.license       = 'MIT'

  spec.executables   = []
  spec.files         = Dir['{app,config,db,lib}/**/*'] + %w{Rakefile README.md LICENSE}
  spec.test_files    = Dir['{test,spec,features}/**/*']

  spec.add_dependency             'rspec', ["~> 3.0"]
  spec.add_dependency             'ruby-progressbar', ["~> 1.4"]

end
