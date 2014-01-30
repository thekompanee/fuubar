Gem::Specification.new 'fuubar', '1.3.2' do |s|
  s.authors               = ['Nicholas Evans', 'Jeff Kreeftmeijer', 'jfelchner']
  s.email                 = ['jeff@kreeftmeijer.nl']
  s.homepage              = 'https://github.com/jeffkreeftmeijer/fuubar'

  s.summary               = 'the instafailing RSpec progress bar formatter'
  s.description           = 'the instafailing RSpec progress bar formatter'
  s.license               = 'MIT'

  s.rdoc_options          = ['--charset', 'UTF-8']
  s.extra_rdoc_files      = %w[README.md LICENSE]

  s.files                 = Dir.glob("lib/**/*")

  s.add_dependency        'rspec',              ['>= 2.14.0', '< 3.1.0']
  s.add_dependency        'ruby-progressbar',   '~> 1.3'
end
