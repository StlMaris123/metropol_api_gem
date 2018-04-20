require 'metropol_api/request_concerns'
module MetropolApi
  class Consumer
    include MetropolApi::RequestConcerns

    def verify(identity_type: nil, identity_number: nil)
      payload = { report_type: 1 }
      path = 'identity/verify'
      fetch(path, payload, identity_type, identity_number)
    end

    def delinquency(loan_amount: 0, identity_type: nil, identity_number: nil)
      payload = { report_type: 2, loan_amount: loan_amount }
      path = 'delinquency/status'
      fetch(path, payload, identity_type, identity_number)
    end

    def consumer_credit(identity_type: nil, identity_number: nil)
      payload = { report_type: 3 }
      path = 'score/consumer'
      fetch(path, payload, identity_type, identity_number)
    end

    def scrub(identity_type: nil, identity_number: nil)
      payload = { report_type: 6 }
      path = 'identity/scrub'
      fetch(path, payload, identity_type, identity_number)
    end
  end
end
