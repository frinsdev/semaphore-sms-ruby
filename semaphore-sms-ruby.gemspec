require_relative 'lib/semaphore_sms/version'

Gem::Specification.new do |spec|
  spec.name        = 'semaphore-sms-ruby'
  spec.version     = SemaphoreSMS::VERSION
  spec.authors     = ['Frins (Prince Karlo)']
  spec.email       = ['frins.dev@gmail.com']
  spec.homepage    = 'https://github.com/frinsdev/semaphore-sms-ruby'
  spec.summary     = 'Ruby API Wrapper for https://semaphore.co/'
  spec.description = 'This gem provides a simple and intuitive Ruby API wrapper for interacting with the Semaphore API.'
  spec.license     = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/frinsdev/semaphore-sms-ruby'
  spec.metadata['changelog_uri'] = 'https://github.com/frinsdev/semaphore-sms-rubyreleases'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.required_ruby_version = '>= 3.2.0'

  spec.add_dependency 'faraday', '~> 2.12'
end
