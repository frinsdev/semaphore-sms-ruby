RSpec.describe SemaphoreSMS::Resources::Messages do
  subject(:messages) { client.messages }

  let(:client) { SemaphoreSMS::Client.new(api_key: 'test-api-key', sender_name: 'TestSender') }
  let(:base_url) { 'https://api.semaphore.co/api/v4' }

  describe '#send' do
    it 'posts a message to /messages' do
      stub = stub_request(:post, "#{base_url}/messages")
             .with(query: hash_including(
               'apikey' => 'test-api-key',
               'sender_name' => 'TestSender',
               'message' => 'Hello',
               'number' => '09998887777'
             ))
             .to_return(status: 200, body: '[{"message_id":1}]', headers: { 'Content-Type' => 'application/json' })

      result = messages.send(message: 'Hello', number: '09998887777')

      expect(stub).to have_been_requested
      expect(result).to eq([{ 'message_id' => 1 }])
    end
  end

  describe '#bulk_send' do
    it 'joins numbers into a comma-separated number param' do
      stub = stub_request(:post, "#{base_url}/messages")
             .with(query: hash_including(
               'message' => 'Hello all',
               'number' => '09991111111,09992222222,09993333333'
             ))
             .to_return(status: 200, body: '[]', headers: { 'Content-Type' => 'application/json' })

      messages.bulk_send(
        message: 'Hello all',
        numbers: %w[09991111111 09992222222 09993333333]
      )

      expect(stub).to have_been_requested
    end
  end

  describe '#retrieve' do
    it 'gets a single message by id' do
      stub = stub_request(:get, "#{base_url}/messages/123")
             .with(query: hash_including('apikey' => 'test-api-key'))
             .to_return(status: 200, body: '{"message_id":123}', headers: { 'Content-Type' => 'application/json' })

      result = messages.retrieve(123)

      expect(stub).to have_been_requested
      expect(result).to eq('message_id' => 123)
    end
  end

  describe '#list' do
    it 'gets messages with camelCase date filters' do
      stub = stub_request(:get, "#{base_url}/messages")
             .with(query: hash_including(
               'limit' => '10',
               'page' => '2',
               'startDate' => '2024-01-01',
               'endDate' => '2024-01-31',
               'network' => 'globe',
               'status' => 'pending'
             ))
             .to_return(status: 200, body: '[]', headers: { 'Content-Type' => 'application/json' })

      messages.list(
        limit: 10,
        page: 2,
        start_date: '2024-01-01',
        end_date: '2024-01-31',
        network: 'globe',
        status: 'pending'
      )

      expect(stub).to have_been_requested
    end

    it 'omits nil filters' do
      stub = stub_request(:get, "#{base_url}/messages")
             .with(query: hash_including('limit' => '5'))
             .to_return(status: 200, body: '[]', headers: { 'Content-Type' => 'application/json' })

      messages.list(limit: 5)

      expect(stub).to have_been_requested
      expect(
        a_request(:get, "#{base_url}/messages")
          .with(query: hash_excluding('startDate', 'endDate', 'network', 'status', 'page'))
      ).to have_been_made
    end
  end
end
