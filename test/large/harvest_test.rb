require_relative "../test_helper"
require_relative "../../lib/pester/adapters/harvest"
require "harvested"
require "logger"

module Pester
  module Adapters
    class HarvestTest < Test::Unit::TestCase
      let(:log_stream) { StringIO.new }
      let(:client) { Harvest.new(
          ENV["HARVEST_SUBDOMAIN"],
          ENV["HARVEST_USERNAME"],
          ENV["HARVEST_PASSWORD"],
          log: Logger.new(log_stream)
      )}

      test "get hours for employee as of date" do
        assert_equal(42.0, client.hours_for("Bnadler@cyrusinnovation.com", Date.new(2014, 2, 15)))
      end

      test "get hours for employee that cannot be found" do
        assert_equal(-1, client.hours_for("no_such_email", Date.new(2014, 2, 15)))
        log_stream.rewind
        assert(/Could not find employee in Harvest \(no_such_email\)/ =~ log_stream.entries.join(""))
      end
    end
  end
end
