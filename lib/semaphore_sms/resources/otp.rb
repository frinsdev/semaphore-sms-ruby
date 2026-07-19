module SemaphoreSMS
  module Resources
    class Otp
      def initialize(client)
        @client = client
      end

      def send(message:, number:, code: nil, **parameters)
        @client.post_request(
          path: '/otp',
          parameters: compact_params(message:, number:, code:, **parameters)
        )
      end

      private

      def compact_params(**parameters)
        parameters.compact
      end
    end
  end
end
