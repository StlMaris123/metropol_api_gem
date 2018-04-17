module MetropolApi
  module IdentityType
    IDENTITY_TYPES = {
      national_id: '001',
      passport: '002',
      service_id: '003',
      alien_registration: '004',
      company_or_business_registration: '005'
    }.freeze

    def valid_identity_types(identity_type)
      raise ArgumentError, 'The id type you provided is not valid' unless
      valid_identity_types? identity_type
      IDENTITY_TYPES[identity_type]
    end

    def valid_identity_types?(identity_type)
       IDENTITY_TYPES.has_key? identity_type
    end
  end
end
