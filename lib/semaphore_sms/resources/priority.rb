module SemaphoreSMS
  module Resources
    class Priority
      def initialize(client)
        @client = client
      end

      def send(message:, number:, **parameters)
        @client.post_request(
          path: '/priority',
          parameters: compact_params(message:, number:, **parameters)
        )
      end

      private

      def compact_params(**parameters)
        parameters.compact
      end
    end
  end
end
