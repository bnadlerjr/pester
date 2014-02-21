module Pester
  class SendMessage
    THRESHOLD = 40.0
    attr_reader :end_on, :employees, :message_service, :time_source

    def initialize(date, **options)
      date = date.prev_day until date.saturday?
      @end_on = date
      @employees = options.fetch(:employees)
      @message_service = options.fetch(:message_service)
      @time_source = options.fetch(:time_source)
    end

    def call
      employees.each do |emp|
        hours = time_source.hours_for(emp, end_on)
        message_service.deliver({
          to: emp.phone,
          from: ENV["FROM_PHONE"],
          body: msg
        }) if hours < THRESHOLD
      end
    end

    private

    def msg
      <<-TEXT.gsub /(^\s*|\n)/, ""
      Hi there! It looks like you haven't entered all your hours into Harvest for the week ending #{end_on}. Please log in to Harvest and enter your hours!
      TEXT
    end
  end
end
