require "metropol_api/version"
require 'metropol_api/consumer'
require 'metropol_api/report'

module MetropolApi
  class << self

    attr_accessor :public_key, :private_key, :port, :api_version

    def report
      @report ||= MetropolApi::Report.new(public_key: @public_key,
                                        private_key: @private_key,
                                        port: @port,
                                        api_version: @api_version)
    end

    def consumer
      @consumer ||= MetropolApi::Consumer.new(public_key: @public_key,
                                            private_key: @private_key,
                                            port: @port,
                                            api_version: @api_version)

    end
  end
end
