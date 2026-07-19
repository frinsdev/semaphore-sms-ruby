RSpec.describe Semaphore::Resources::Priority do
  subject(:priority) { client.priority }

  let(:client) { Semaphore::Client.new(api_key: 'test-api-key', sender_name: 'TestSender') }
  let(:base_url) { 'https://api.semaphore.co/api/v4' }

  describe '#send' do
    it 'posts a priority message to /priority' do
      stub = stub_request(:post, "#{base_url}/priority")
             .with(query: hash_including(
               'apikey' => 'test-api-key',
               'sender_name' => 'TestSender',
               'message' => 'Urgent hello',
               'number' => '09998887777'
             ))
             .to_return(status: 200, body: '[{"type":"priority"}]', headers: { 'Content-Type' => 'application/json' })

      result = priority.send(message: 'Urgent hello', number: '09998887777')

      expect(stub).to have_been_requested
      expect(result).to eq([{ 'type' => 'priority' }])
    end
  end
end
