require 'faraday'

require_relative 'semaphore/http'
require_relative 'semaphore/resources/messages'
require_relative 'semaphore/resources/priority'
require_relative 'semaphore/resources/otp'
require_relative 'semaphore/resources/account'
require_relative 'semaphore/client'
require_relative 'semaphore/version'

module Semaphore
  class Error < StandardError; end
  class ConfigurationError < Error; end

  class Configuration
    attr_writer :api_key, :sender_name
    attr_accessor :api_version, :uri_base, :request_timeout

    DEFAULT_API_VERSION = 'v4'.freeze
    DEFAULT_URI_BASE = 'https://api.semaphore.co/api/'.freeze
    DEFAULT_REQUEST_TIMEOUT = 120

    def initialize
      @api_key = nil
      @api_version = DEFAULT_API_VERSION
      @sender_name = nil
      @uri_base = DEFAULT_URI_BASE
      @request_timeout = DEFAULT_REQUEST_TIMEOUT
    end

    def api_key
      return @api_key if @api_key

      error_text = 'Semaphore access token missing! See https://semaphore.co/docs'
      raise ConfigurationError, error_text
    end

    def sender_name
      return @sender_name if @sender_name

      error_text = 'Semaphore sender name missing! See https://semaphore.co/docs'
      raise ConfigurationError, error_text
    end
  end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Semaphore::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
