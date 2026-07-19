module Semaphore
  module Resources
    class Account
      def initialize(client)
        @client = client
      end

      def retrieve
        @client.get_request(path: '/account')
      end

      def transactions(limit: nil, page: nil)
        @client.get_request(
          path: '/account/transactions',
          parameters: compact_params(limit:, page:)
        )
      end

      def sender_names(limit: nil, page: nil)
        @client.get_request(
          path: '/account/sendernames',
          parameters: compact_params(limit:, page:)
        )
      end

      def users(limit: nil, page: nil)
        @client.get_request(
          path: '/account/users',
          parameters: compact_params(limit:, page:)
        )
      end

      private

      def compact_params(**parameters)
        parameters.compact
      end
    end
  end
end
