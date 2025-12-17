require_relative 'lib/omniauth-tidal/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-tidal'
  spec.version       = OmniAuth::Tidal::VERSION
  spec.authors       = ['Syborg Studios']
  spec.email         = ['info@syborgstudios.com']

  spec.summary       = 'OmniAuth strategy for Tidal'
  spec.description   = 'OmniAuth OAuth2 strategy for Tidal API authentication'
  spec.homepage      = 'https://github.com/SyborgStudios/omniauth-tidal'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/SyborgStudios/omniauth-tidal'
  spec.metadata['changelog_uri'] = 'https://github.com/SyborgStudios/omniauth-tidal/blob/main/CHANGELOG.md'

  spec.files = Dir['lib/**/*.rb', 'LICENSE', 'README.md']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'omniauth-oauth2', '~> 1.1'

  spec.add_development_dependency 'bundler', '>= 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 3.0'
end
