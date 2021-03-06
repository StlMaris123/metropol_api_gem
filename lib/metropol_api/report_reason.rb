module MetropolApi
  module ReportReason
    REPORT_REASONS = {
      new_credit_application: 1,
      existing_credit_review: 2,
      verify_customer_details: 3,
      direct_customer_request: 4
    }.freeze

    def valid_reason_types?(reason_type)
      REPORT_REASONS.has_key? reason_type
    end

    def method_missing(method_name, *args, &block)
      if valid_reason_types? method_name
        @payload[:report_reason] =  REPORT_REASONS[method_name]
        return self
      end
      super
    end
  end
end
