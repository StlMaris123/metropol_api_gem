require 'metropol_api/identity_type'
require 'metropol_api/api_request'


module MetropolApi
  class Consumer
    include MetropolApi::IdentityType

    def initialize(public_key:, private_key:, port:, api_version:)
      @public_key = public_key
      @private_key = private_key
      @port = port
      @api_version = api_version
    end

    def verify_identity_number(identity_type: nil, identity_number: nil)
      payload = { report_type: 1 }
      path = 'identity/verify'
      fetch(path, payload, identity_type, identity_number)
    end

    def deliquency_status(loan_amount: 0, identity_type: nil, identity_number: nil)
      payload = { report_type: 2, loan_amount: loan_amount }
      path = 'deliquency/status'
      fetch(path, payload, identity_type, identity_number)
    end

    def consumer_credit(identity_type: nil, identity_number: nil)
      payload = { report_type: 3 }
      path = 'score/consumer'
      fetch(path, payload, identity_number, identity_path)
    end

    def noncredit_information(identity_number: nil, identity_type: nil)
      payload = { report_type: 6 }
      path = 'identity/scrub'
      fetch(path, payload, identity_type, identity_number)
    end

    private

    def fetch(path, payload, identity_type, identity_number)
      valid_request = check_request_status(path, payload)
      return valid_request.send(identity_type, identity_number) if
      request_has_valid? identity_type, identity_number
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
