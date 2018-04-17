require 'test_helper'

describe MetropolApi::IdentityType do

  describe 'when the id type is valid' do
    it 'returns the correct value' do
      @consumer = MetropolApi::Consumer.new(public_key: 'public', private_key: 'private', port: 123, api_version: 'v2')
      id = @consumer.valid_identity_types(:national_id)
      assert String, id.class
      assert id,  MetropolApi::IdentityType::IDENTITY_TYPES[:passport]
    end
  end

  describe 'When the id type id invalid' do
    it 'raises an error' do
      @consumer = MetropolApi::Consumer.new(public_key: 'public', private_key: 'private', port: 123, api_version: 'v2')
      assert_raises(ArgumentError) { @consumer.valid_identity_types(:national)}
    end
  end
end
