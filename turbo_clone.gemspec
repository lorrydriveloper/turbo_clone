# frozen_string_literal: true

require_relative 'lib/turbo_clone/version'

Gem::Specification.new do |spec|
  spec.name        = 'turbo_clone'
  spec.version     = TurboClone::VERSION
  spec.authors     = ['Pedro D. Garcia Lopez']
  spec.email       = ['lorrydriveloper@gmail.com']
  spec.summary     = 'Turbo Rails clone to learn the internals of Rails.'
  spec.license     = 'MIT'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.add_dependency 'rails', '>= 7.0.5'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
