require_relative 'lib/blog/version'

Gem::Specification.new do |spec|
  spec.name        = 'blog'
  spec.version     = Blog::VERSION
  spec.authors     = ['masi']
  spec.email       = ['masi@fozzy.com']
  spec.homepage    = 'https://hexlet.io'
  spec.summary     = 'Hexlet homework Rails stats engine'
  spec.description = 'Hexlet homework Rails stats engine'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata['allowed_push_host'] = 'https://github.com/hexlet'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.metadata['homepage_uri'] = spec.homepage
  #spec.metadata['source_code_uri'] = 'https://example.com'
  #spec.metadata['changelog_uri'] = 'https://example.com'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.add_dependency 'rails', '>= 7.1.3.3'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
