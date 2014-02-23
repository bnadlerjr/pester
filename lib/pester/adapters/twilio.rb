module Pester
  module Adapters
    class Twilio
      attr_reader :client, :deliveries, :log

      def initialize(account_sid, auth_token, **opts)
        @client = ::Twilio::REST::Client.new(account_sid, auth_token)
        @deliveries = []
        @log = opts.fetch(:log)
      end

      def deliver(**args)
        deliveries << @client.account.messages.create(**args)
      rescue ::Twilio::REST::RequestError => error
        log.error("Exception occurred when making Twilio request")
        log.error(error.message)
        log.error(error.backtrace.join("\n"))
      end
    end
  end
end
