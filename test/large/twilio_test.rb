require_relative "../test_helper"
require_relative "../../lib/pester/adapters/twilio"
require "logger"
require "stringio"
require "twilio-ruby"

module Pester
  module Adapters
    class TwilioTest < Test::Unit::TestCase
      # Twilio "MAGIC" numbers
      # see https://www.twilio.com/docs/api/rest/test-credentials#test-sms-messages
      SMS_INCAPABLE_NUMBER = "+15005550009"
      VALID_NUMBER         = "+15005550006"

      let(:log_stream) { StringIO.new }
      let(:log) { Logger.new(log_stream) }
      let(:twilio) { Twilio.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"], log: log) }

      test "successfully deliver an SMS message" do
        twilio.deliver(from: VALID_NUMBER, to: VALID_NUMBER, body: "Test")
        assert_equal(1, twilio.deliveries.count)
        actual = twilio.deliveries[0]
        assert_equal(VALID_NUMBER, actual.from)
        assert_equal(VALID_NUMBER, actual.to)
        assert_equal("Test", actual.body)
        assert_equal("queued", actual.status) # Twilio sets status to "queued" when sending w/ test credentials
      end

      test "logs any errors" do
        twilio.deliver(from: VALID_NUMBER, to: SMS_INCAPABLE_NUMBER, body: "Test")
        assert_equal(0, twilio.deliveries.count)
        log_stream.rewind
        assert(/To number: \+15005550009, is not a mobile number/ =~ log_stream.entries.join(""))
      end
    end
  end
end
