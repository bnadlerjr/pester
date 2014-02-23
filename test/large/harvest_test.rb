require_relative "../test_helper"
require_relative "../../lib/pester/adapters/harvest"
require "harvested"

module Pester
  module Adapters
    class HarvestTest < Test::Unit::TestCase
      test "get hours for employee as of date" do
        h = Harvest.new(ENV["HARVEST_SUBDOMAIN"], ENV["HARVEST_USERNAME"], ENV["HARVEST_PASSWORD"])
        assert_equal(42.0, h.hours_for("Bnadler@cyrusinnovation.com", Date.new(2014, 2, 15)))
      end
    end
  end
end
