require 'metropol_api/request_concerns'

module MetropolApi
  class Report
    include MetropolApi::RequestConcerns

    def pdf_report(identity_type: nil, identity_number: nil, report_reason: 1, loan_amount: 0)
      payload = { report_type: 4, loan_amount: loan_amount, report_reason: report_reason }
      path = 'report/pdf'
      fetch(path, payload, identity_type, identity_number)
    end

    def json_report(identity_type: nil, identity_number: nil, loan_amount: 0, report_reason: 1)
      payload = {report_type: 5, loan_amount: loan_amount, report_reason: report_reason}
      path = 'report/json'
      fetch(path, payload, identity_type, identity_number)
    end

    def credit_information(identity_type: nil, identity_number: nil, loan_amount: 0, report_reason: 1)
      payload = {report_type: 8, loan_amount: loan_amount, report_reason: report_reason}
      path = 'report/credit_info'
      fetch(path, payload, identity_type, identity_number)
    end
  end
end
