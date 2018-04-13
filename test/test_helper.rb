$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "metropol_api"

require "minitest/autorun"
require 'webmock/minitest'
include WebMock::API
