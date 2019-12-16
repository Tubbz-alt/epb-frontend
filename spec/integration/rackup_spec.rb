require 'net/http'

describe 'Running behind Rack server' do
  before(:all) do
    puts '' # Add newline to test output before WEBrick log output
    process = IO.popen('rackup -q')
    @process_id = process.pid

    sleep 2
  end

  after(:all) { Process.kill('KILL', @process_id) }

  let(:request) { Net::HTTP.new('localhost', 9292) }

  describe 'GET /' do
    it 'renders the home page' do
      req = Net::HTTP::Get.new('/')
      response = request.request(req)
      expect(response.code).to eq('200')
      expect(response.body).to include('Energy performance of buildings')
    end
  end

  describe 'GET /healthcheck' do
    it 'passes a healthcheck' do
      req = Net::HTTP::Get.new('/healthcheck')
      response = request.request(req)
      expect(response.code).to eq('200')
    end
  end

  describe 'GET non-existent page' do
    it 'returns status 404' do
      req = Net::HTTP::Get.new('/this-page-does-not-exist')
      response = request.request(req)
      expect(response.code).to eq('404')
    end
  end
end
