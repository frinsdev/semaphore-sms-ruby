RSpec.describe SemaphoreSMS::Client do
  subject(:client) do
    described_class.new(api_key: 'test-api-key', sender_name: 'TestSender')
  end

  it 'exposes a messages resource' do
    expect(client.messages).to be_a(SemaphoreSMS::Resources::Messages)
  end

  it 'exposes a priority resource' do
    expect(client.priority).to be_a(SemaphoreSMS::Resources::Priority)
  end

  it 'exposes an otp resource' do
    expect(client.otp).to be_a(SemaphoreSMS::Resources::Otp)
  end

  it 'exposes an account resource' do
    expect(client.account).to be_a(SemaphoreSMS::Resources::Account)
  end

  it 'memoizes resource instances' do
    expect(client.messages).to equal(client.messages)
    expect(client.priority).to equal(client.priority)
    expect(client.otp).to equal(client.otp)
    expect(client.account).to equal(client.account)
  end

  it 'assigns configuration from initialize' do
    expect(client.api_key).to eq('test-api-key')
    expect(client.sender_name).to eq('TestSender')
  end
end
