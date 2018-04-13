require "test_helper"

class MetropolApiTest < Minitest::Test

  describe 'Generating Api URL' do
    it 'should be in the correct format' do
      @request = MetropolApi::ApiRequest.new(public_key: 'public', private_key: 'private', path: 'testing', port: 3000, api_version: 'v2')
      url = 'https://api.metropol.co.ke:3000/v2/testing'
      assert_equal @request.api_url, url
    end
  end

  describe 'Generating Api headers' do
    it 'returns the required keys' do
      @request = MetropolApi::ApiRequest.new(public_key: 'public', private_key: 'private', path: 'testing', port: 5555, api_version: 'v2_1')
      headers = @request.api_headers
      refute_nil headers['X-METROPOL-REST-API-KEY']
      refute_nil headers['X-METROPOL-REST-API-TIMESTAMP']
      refute_nil headers['X-METROPOL-REST-API-HASH']
    end
  end

  describe 'api time stamp' do
    it 'has 20 characters' do
      @request = MetropolApi::ApiRequest.new(public_key: 'public', private_key: 'private', path: 'testing', port: 5555, api_version: 'v2_1')
      assert 20, @request.api_timestamp.length
    end
  end

  describe 'X-METROPOL-REST-API-HASH' do
    it "returns a sha256 hexdigest length string" do
      @request = MetropolApi::ApiRequest.new(public_key: 'public', private_key: 'private', path: 'testing', port: 5555, api_version: 'v2_1')
      time_stamp = @request.api_timestamp
      rest_api_hash = @request.rest_api_hash(time_stamp)
      assert 64,  rest_api_hash.length
      assert String, rest_api_hash.class
    end
  end

end
