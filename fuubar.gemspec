# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'fuubar'
  spec.version       = '2.4.0'
  spec.authors       = ['Nicholas Evans', 'Jeff Kreeftmeijer', 'jfelchner']
  spec.email         = ['jeff@kreeftmeijer.nl', 'accounts+git@thekompanee.com']
  spec.summary       = %q{the instafailing RSpec progress bar formatter}
  spec.description   = %q{the instafailing RSpec progress bar formatter}
  spec.homepage      = 'https://github.com/thekompanee/fuubar'
  spec.licenses      = ['MIT']

  spec.cert_chain    = ['certs/thekompanee.pem']
  spec.signing_key   = File.expand_path('~/.gem/certs/thekompanee-private_key.pem') if $0 =~ /gem\z/

  spec.executables   = []
  spec.files         = Dir['{app,config,db,lib,templates}/**/*'] + %w{README.md LICENSE.txt}

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.add_dependency             'rspec-core',       ["~> 3.0"]
  spec.add_dependency             'ruby-progressbar', ["~> 1.4"]

  spec.add_development_dependency 'rspec',            ["~> 3.7"]
end
