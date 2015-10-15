module PushType
  module Primitives
    class Base

      def self.to_json(val)
        new(val).to_json
      end

      attr_reader :value

      def initialize(value)
        @value = value
      end

      def to_json
        value.as_json
      end

    end
  end
end
