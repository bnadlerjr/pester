module Pester
  module Adapters
    class Harvest
      attr_reader :client, :log

      def initialize(subdomain, username, password, **opts)
        @client = ::Harvest.hardy_client(subdomain, username, password)
        @log = opts.fetch(:log) { Pester::adapters[:log] }
      end

      def hours_for(email, as_of)
        user = client.users.find(email)
        hours = client.reports.time_by_user(user.id, as_of - 7, as_of).map(&:hours).reduce(0, &:+)
      rescue ::Harvest::NotFound => error
        log.error("Could not find employee in Harvest (#{email})")
        -1
      rescue ::Harvest::HTTPError => error
        log.error("An HTTP error occurred while making a request to Harvest")
        log.error("Hint: #{error.hint}") if error.hint
        log.error("Params: #{error.params}")
        log.error("Response: #{error.response}")
        log.error(error.backtrace.join("\n"))
        -1
      end
    end
  end
end
