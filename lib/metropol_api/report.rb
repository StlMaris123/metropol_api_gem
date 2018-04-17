require 'metropol_api/identity_type'
require 'metropol_api/api_request'

module MetropolApi
  class Report
    include MetropolApi::IdentityType

    def initialize(public_key:, private_key:, port:, api_version:)
      @public_key = public_key
      @private_key = private_key
      @port = port
      @api_version = api_version
    end

    def pdf_report(identity_type: nil, identity_number: nil, credit_type: nil, report_reason: 1)
      payload = { report_type: 4, report_reason: report_reason }
      path = 'report/pdf'
      fetch(path, payload, identity_type, identity_number)
    end

    def json_report(identity_type: nil, identity_number: nil, loan_amount: 0, report_reason: 1)
      payload = {report_type: 5, loan_amount: loan_amount, report_reason: report_reason}
      path = 'report/json'
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
