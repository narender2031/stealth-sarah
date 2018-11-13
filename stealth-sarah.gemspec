$LOAD_PATH.push File.expand_path('../lib', __FILE__)

version = File.read(File.join(File.dirname(__FILE__), 'VERSION')).strip

Gem::Specification.new do |s|
  s.name = 'stealth-sarah'
  s.summary = 'Stealth driver for MedConnect\'s Sarah'
  s.description = 'MedConnect driver for Stealth.'
  s.homepage = 'https://bitbucket.org/medconnectio/mono/stealth/stealth-sarah'
  s.licenses = ['MIT']
  s.version = version
  s.author = 'Jeremy Becker'
  s.email = 'jeremy@medconnectapp.ca'

  s.add_dependency 'stealth', '< 2.0'
  s.add_dependency 'graphql-client', '0.13.0'

  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'rspec_junit_formatter', '~> 0.3'
  s.add_development_dependency 'rack-test', '~> 0.7'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']
end
