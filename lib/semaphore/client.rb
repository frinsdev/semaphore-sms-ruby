module Semaphore
  class Client
    include Semaphore::HTTP

    CONFIG_KEYS = %i[
      api_version
      api_key
      sender_name
      uri_base
      request_timeout
    ].freeze

    attr_reader(*CONFIG_KEYS)

    def initialize(config = {})
      CONFIG_KEYS.each do |key|
        instance_variable_set("@#{key}", config[key] || Semaphore.configuration.send(key))
      end
    end

    def messages
      @messages ||= Resources::Messages.new(self)
    end

    def priority
      @priority ||= Resources::Priority.new(self)
    end

    def otp
      @otp ||= Resources::Otp.new(self)
    end

    def account
      @account ||= Resources::Account.new(self)
    end
  end
end
