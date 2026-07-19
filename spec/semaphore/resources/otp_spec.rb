RSpec.describe Semaphore::Resources::Otp do
  subject(:otp) { client.otp }

  let(:client) { Semaphore::Client.new(api_key: 'test-api-key', sender_name: 'TestSender') }
  let(:base_url) { 'https://api.semaphore.co/api/v4' }

  describe '#send' do
    it 'posts an otp message to /otp' do
      stub = stub_request(:post, "#{base_url}/otp")
             .with(query: hash_including(
               'message' => 'Your OTP is {otp}',
               'number' => '09998887777'
             ))
             .to_return(
               status: 200,
               body: '[{"code":332200}]',
               headers: { 'Content-Type' => 'application/json' }
             )

      result = otp.send(message: 'Your OTP is {otp}', number: '09998887777')

      expect(stub).to have_been_requested
      expect(result).to eq([{ 'code' => 332_200 }])
    end

    it 'includes a custom code when provided' do
      stub = stub_request(:post, "#{base_url}/otp")
             .with(query: hash_including('code' => '1234'))
             .to_return(status: 200, body: '[{"code":1234}]', headers: { 'Content-Type' => 'application/json' })

      otp.send(message: 'Your OTP is {otp}', number: '09998887777', code: 1234)

      expect(stub).to have_been_requested
    end

    it 'omits code when not provided' do
      stub = stub_request(:post, "#{base_url}/otp")
             .with(query: hash_including(
               'message' => 'Your OTP is {otp}',
               'number' => '09998887777'
             ))
             .to_return(status: 200, body: '[]', headers: { 'Content-Type' => 'application/json' })

      otp.send(message: 'Your OTP is {otp}', number: '09998887777')

      expect(stub).to have_been_requested
      expect(
        a_request(:post, "#{base_url}/otp")
          .with(query: hash_excluding('code'))
      ).to have_been_made
    end
  end
end
