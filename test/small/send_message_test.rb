require "date"
require_relative "../test_helper"
require_relative "../../lib/pester"

module Pester
  class SendMessageTest < Test::Unit::TestCase
    let(:message_service) { FakeMessageService.new }
    let(:time_source) { FakeTimeSource.new }

    setup do
      ENV["FROM_PHONE"] = "+10005550000"
    end

    test "successfully send message" do
      employees = [Employee.new(email: "jdoe@example.com", phone: "+10005551234")]
      build_send_message_command(employees).call
      assert_equal([{
        to: "+10005551234",
        from: "+10005550000",
        body: "Hi there! It looks like you haven't entered all your hours into Harvest for the week ending 2014-02-15. Please log in to Harvest and enter your hours!"
      }], message_service.deliveries)
    end

    test "does not send message if hours are greater than or equal to threshold" do
      employees = [Employee.new(email: "jsmith@example.com", phone: "+10005559876")]
      build_send_message_command(employees).call
      assert_equal([], message_service.deliveries)
    end

    private

    def build_send_message_command(employees)
      SendMessage.new(
        Date.new(2014, 2, 20),
        employees: employees,
        message_service: message_service,
        time_source: time_source
      )
    end

    class FakeMessageService
      attr_reader :deliveries
      def initialize; @deliveries = []; end
      def deliver(msg); @deliveries << msg; end
    end

    class FakeTimeSource
      def hours_for(employee, end_on)
        raise "wrong end_on date" unless Date.new(2014, 2, 15) == end_on
        return 35.0 if "jdoe@example.com" == employee.email
        return 40.0 if "jsmith@example.com" == employee.email
      end
    end
  end
end
