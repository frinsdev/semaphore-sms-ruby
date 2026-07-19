require_relative 'lib/semaphore/version'

Gem::Specification.new do |spec|
  spec.name        = 'ruby-semaphore'
  spec.version     = Semaphore::VERSION
  spec.authors     = ['Prince Karlo']
  spec.email       = ['77134068+princekarlo-bootyard@users.noreply.github.com']
  spec.homepage    = 'https://bootyard.com'
  spec.summary     = 'Ruby API Wrapper for https://semaphore.co/'
  spec.description = 'This gem provides a simple and intuitive Ruby API wrapper for interacting with the Semaphore API.'
  spec.license     = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/princekarlo-bootyard/ruby-semaphore'
  spec.metadata['changelog_uri'] = 'https://github.com/princekarlo-bootyard/ruby-semaphore/releases'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.required_ruby_version = '>= 3.2.0'

  spec.add_dependency 'faraday', '~> 2.7.12'
end
