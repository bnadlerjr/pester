require "csv"
require_relative "../employee"

module Pester
  module Adapters
    class EmployeeCsvMapper
      attr_reader :filename

      def initialize(filename)
        @filename = filename
      end

      def each
        CSV.foreach(filename) do |line|
          yield Pester::Employee.new(
            email: line[0],
            phone: line[1]
          )
        end
      end
    end
  end
end
