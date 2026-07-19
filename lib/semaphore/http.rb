module Semaphore
  module HTTP
    def post_request(path:, parameters: {})
      conn.post(uri(path:)) do |req|
        configure_request_params(req, parameters)
      end&.body
    end

    def get_request(path:, parameters: {})
      conn.get(uri(path:)) do |req|
        configure_request_params(req, parameters)
      end&.body
    end

    private

    def configure_request_params(req, parameters)
      req_parameters = parameters.dup
      req_parameters[:apikey] = @api_key
      req_parameters[:sender_name] = @sender_name
      req.params = req_parameters
    end

    def conn
      Faraday.new do |f|
        f.options[:timeout] = @request_timeout
        f.response :raise_error
        f.response :json
      end
    end

    def uri(path:)
      URI("#{@uri_base}#{@api_version}#{path}")
    end
  end
end
