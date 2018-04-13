module MetropolApi
  module IdentityType
    IDENTITY_TYPES = {
      national_id: '001',
      passport: '002',
      service_id: '003',
      alien_registration: '004',
      company_or_business_registration: '005'
    }.freeze

    def valid_identity_types
      raise ArgumentError, 'The id type you provided is not valid' unless
      IDENTITY_TYPES.has_key? id_type
    end
  end
end
