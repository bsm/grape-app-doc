# encoding: utf-8

Gem::Specification.new do |s|
  s.name          = 'grape-app-doc'
  s.version       = '0.0.1'
  s.authors       = ['Black Square Media Ltd']
  s.email         = ['info@blacksquaremedia.com']
  s.summary       = %{Grape app documentation}
  s.description   = %{EXPERIMENTAL}
  s.homepage      = 'https://github.com/bsm/grape-app-doc'
  s.license       = 'MIT'

  s.files         = `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^spec/}) }
  s.test_files    = `git ls-files -z -- spec/*`.split("\x0")
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency 'grape-app'
  s.add_development_dependency 'bundler'
end

