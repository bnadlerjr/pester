require_relative "../test_helper"
require_relative "../../lib/pester/adapters/employee_csv_mapper"
require_relative "../../lib/pester/employee"
require "csv"

module Pester
  module Adapters
    class EmployeeCsvMapperTest < Test::Unit::TestCase
      test "yields each employee from file" do
        filename = File.join(File.dirname(__FILE__), "../data/employees.txt")
        employees = EmployeeCsvMapper.new(filename)

        yielded = []
        employees.each { |emp| yielded << emp }

        assert_equal("wwhite@example.com", yielded[0].email)
        assert_equal("+10005559012", yielded[0].phone)

        assert_equal("dwinchester@example.com", yielded[1].email)
        assert_equal("+10005553456", yielded[1].phone)
      end
    end
  end
end
