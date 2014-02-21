module Pester
  Employee = Struct.new(
    :email,
    :phone
  ) do
    def initialize(**attrs)
      attrs.each { |k, v| self[k] = v }
    end
  end
end
