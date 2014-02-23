module Pester
  class SendMessage
    THRESHOLD = 39
    attr_reader :end_on, :employees, :message_service, :time_source, :log

    def self.call(date)
      new(date).call
    end

    def initialize(date, **options)
      date = date.prev_day until date.saturday?
      @end_on = date
      @employees = options.fetch(:employees) { Pester.adapters[:employees] }
      @message_service = options.fetch(:message_service) { Pester.adapters[:messages] }
      @time_source = options.fetch(:time_source) { Pester.adapters[:time_source] }
      @log = options.fetch(:log) { Pester.adapters[:log] }
    end

    def call
      employees.each do |emp|
        hours = time_source.hours_for(emp.email, end_on)
        if hours.between?(0, THRESHOLD)
          message_service.deliver({
            to: emp.phone,
            from: ENV["FROM_PHONE"],
            body: msg
          })
          log.info("Sent message to #{emp.email} (#{emp.phone})")
        end
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
