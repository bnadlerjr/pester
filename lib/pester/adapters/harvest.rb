module Pester
  module Adapters
    class Harvest
      attr_reader :client

      def initialize(subdomain, username, password)
        @client = ::Harvest.hardy_client(subdomain, username, password)
      end

      def hours_for(email, as_of)
        user = client.users.find(email)
        hours = client.reports.time_by_user(user.id, as_of - 7, as_of).map(&:hours).reduce(0, &:+)
      end
    end
  end
end
