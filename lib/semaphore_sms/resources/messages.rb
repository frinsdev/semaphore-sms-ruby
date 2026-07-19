module SemaphoreSMS
  module Resources
    class Messages
      def initialize(client)
        @client = client
      end

      def send(message:, number:, **parameters)
        @client.post_request(
          path: '/messages',
          parameters: compact_params(message:, number:, **parameters)
        )
      end

      def bulk_send(message:, numbers:, **parameters)
        @client.post_request(
          path: '/messages',
          parameters: compact_params(
            message:,
            number: Array(numbers).join(','),
            **parameters
          )
        )
      end

      def retrieve(id)
        @client.get_request(path: "/messages/#{id}")
      end

      def list(limit: nil, page: nil, start_date: nil, end_date: nil, network: nil, status: nil)
        @client.get_request(
          path: '/messages',
          parameters: compact_params(
            limit:,
            page:,
            startDate: start_date,
            endDate: end_date,
            network:,
            status:
          )
        )
      end

      private

      def compact_params(**parameters)
        parameters.compact
      end
    end
  end
end
