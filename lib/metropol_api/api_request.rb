require 'uri'
require 'rest-client'
require 'json'
require 'digest'
require 'metropol_api/default_configurations'
require 'metropol_api/report_reason'
require 'metropol_api/identity_type'

module MetropolApi
  class ApiRequest

    include MetropolApi::DefaultConfigurations
    include MetropolApi::ReportReason
    include MetropolApi::IdentityType

    def initialize(public_key:, private_key:, path:, port:, api_version:, payload: {})
      @private_key = private_key
      @public_key = public_key
      @path = path
      @port = port
      @api_version = api_version
      @payload = payload
    end

    def api_headers
      headers = default_headers
      @api_timestamp = api_timestamp
      headers['X-METROPOL-REST-API-KEY'] = @public_key
      headers['X-METROPOL-REST-API-TIMESTAMP'] = @api_timestamp
      headers['X-METROPOL-REST-API-HASH'] = rest_api_hash(@api_timestamp)
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

    def method_missing(method_name, *args, &block)
      if valid_identity_types? method_name
        @payload[:identity_number] = args.first
        @payload[:identity_type] = valid_identity_types(method_name)
        match_api_hash!
         return post
      end
      super
    end

    private

    def match_api_hash!
      partition = @payload.partition do |key, value|
        [:report_type, :identity_number, :identity_type].include? key
      end
      @payload = partition.flatten(1).to_h
    end


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
