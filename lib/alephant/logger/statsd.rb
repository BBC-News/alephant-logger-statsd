require "alephant/logger/statsd/version"
require "statsd-ruby"

module Alephant
  module Logger
    class Statsd
      def initialize(config = {})
        connect defaults.merge(config)
      end

      def increment(key, interval = 1)
        server.increment(key, interval)
      end

      private

      attr_reader :server

      def connect(config)
        @server = ::Statsd.new(config[:host], config[:port]).tap do |s|
          s.namespace = config[:namespace]
        end
      end

      def defaults
        {
          :host      => "localhost",
          :port      => 8125,
          :namespace => "statsd"
        }
      end
    end
  end
end
