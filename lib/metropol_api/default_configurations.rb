module MetropolApi
  module DefaultConfigurations
    HOST = 'api.metropol.co.ke'.freeze
    DEFAULT_PORT = 5555.freeze
    DEFAULT_API_VERSION = 'v2_1'.freeze
    HEADERS = { 'Accept' => 'application/json',
                'Content-Type' => 'application/json' }.freeze

    def default_headers
      HEADERS.dup
    end
  end
end
