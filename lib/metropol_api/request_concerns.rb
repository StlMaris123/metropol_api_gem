require 'metropol_api/identity_type'
require 'metropol_api/api_request'
module MetropolApi
  module RequestConcerns
    include MetropolApi::IdentityType
    def initialize(public_key:, private_key:, port:, api_version:)
      @public_key = public_key
      @private_key = private_key
      @port = port
      @api_version = api_version
    end

    private

    def fetch(path, payload, identity_type, identity_number)
      valid_request = check_request_status(path, payload)
      if request_has_valid? identity_type, identity_number
        return valid_request.send(identity_type, identity_number) 
      end
      valid_request
    end

    def check_request_status(path, payload)
      ApiRequest.new(public_key: @public_key,
                     private_key: @private_key,
                     path: path,
                     port: @port,
                     api_version: @api_version,
                     payload: payload
                    )

    end

    def request_has_valid? identity_type, identity_number
      valid_identity_types?(identity_type) && !(identity_number.nil?)
    end
  end
end
