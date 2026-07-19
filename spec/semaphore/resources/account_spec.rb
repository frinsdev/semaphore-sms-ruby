RSpec.describe Semaphore::Resources::Account do
  subject(:account) { client.account }

  let(:client) { Semaphore::Client.new(api_key: 'test-api-key', sender_name: 'TestSender') }
  let(:base_url) { 'https://api.semaphore.co/api/v4' }

  describe '#retrieve' do
    it 'gets account details' do
      stub = stub_request(:get, "#{base_url}/account")
             .with(query: hash_including('apikey' => 'test-api-key'))
             .to_return(
               status: 200,
               body: '{"account_id":1,"credit_balance":100}',
               headers: { 'Content-Type' => 'application/json' }
             )

      result = account.retrieve

      expect(stub).to have_been_requested
      expect(result).to eq('account_id' => 1, 'credit_balance' => 100)
    end
  end

  describe '#transactions' do
    it 'gets account transactions with pagination' do
      stub = stub_request(:get, "#{base_url}/account/transactions")
             .with(query: hash_including('limit' => '50', 'page' => '1'))
             .to_return(status: 200, body: '[]', headers: { 'Content-Type' => 'application/json' })

      account.transactions(limit: 50, page: 1)

      expect(stub).to have_been_requested
    end
  end

  describe '#sender_names' do
    it 'gets account sender names' do
      stub = stub_request(:get, "#{base_url}/account/sendernames")
             .with(query: hash_including('apikey' => 'test-api-key'))
             .to_return(status: 200, body: '[]', headers: { 'Content-Type' => 'application/json' })

      account.sender_names

      expect(stub).to have_been_requested
    end
  end

  describe '#users' do
    it 'gets account users' do
      stub = stub_request(:get, "#{base_url}/account/users")
             .with(query: hash_including('apikey' => 'test-api-key'))
             .to_return(status: 200, body: '[]', headers: { 'Content-Type' => 'application/json' })

      account.users

      expect(stub).to have_been_requested
    end
  end
end
