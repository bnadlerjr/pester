require_relative "../test_helper"
require_relative "../../lib/pester/employee"

module Pester
  class EmployeeTest < Test::Unit::TestCase
    test "initialize without attributes" do
      assert_not_nil(Employee.new)
    end

    test "initialize with attributes" do
      employee = Employee.new(email: "jdoe@example.com", phone: "+10005551234")
      assert_equal("jdoe@example.com", employee.email)
      assert_equal("+10005551234", employee.phone)
    end
  end
end
