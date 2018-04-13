require "metropol_api/version"
require 'uri'
require 'rest-client'
require 'json'
require 'digest'
require 'metropol_api/default_configurations'

module MetropolApi
  class ApiRequest

    include MetropolApi::DefaultConfigurations

    def initialize(private_key:, public_key:, path:, port:, api_version:, payload: {})
      @private_key = private_key
      @public_key = public_key
      @path = path
      @port = port
      @api_version = api_version
      @payload = payload
    end

    def api_headers
      headers = default_headers
      headers['X-METROPOL-REST-API-KEY'] = @public_key
      headers['X-METROPOL-REST-API-TIMESTAMP'] = rest_api_hash(api_timestamp)
      headers['X-METROPOL-REST-API-HASH'] = api_timestamp
      headers
    end

    def api_timestamp
      utc_time = Time.now.utc
      utc_time.strftime('%Y%m%d%H%M%S%6N')
    end

    def rest_api_hash(api_timestamp)
      json_object = JSON.generate(@payload)
      expected_key = @private_key + json_object + @public_key + api_timestamp
      Digest::SHA256.hexdigest(expected_key.encode('UTF-8'))
    end

    def api_url
      URI::HTTPS.build(
        host: HOST,
        port: port,
        path: "/#{api_version}/#{@path}"

      ).to_s
    end

    def post
      response = RestClient.post(api_url, json_payload, api_headers)
      JSON.parse response.body
    end

    private

    def port
      @port || DEFAULT_PORT
    end

    def api_version
      @api_version || DEFAULT_API_VERSION
    end

    def json_payload
      @payload.to_json
    end
  end

end
