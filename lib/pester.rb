require "csv"
require "harvested"
require "twilio-ruby"

require_relative "pester/send_message"
require_relative "pester/employee"

require_relative "pester/adapters/employee_csv_mapper"
require_relative "pester/adapters/twilio"
require_relative "pester/adapters/harvest"

module Pester
  def self.adapters
    @adapters ||= {}
  end
end
