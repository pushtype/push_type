module PushType
  module Primitives
    class BooleanType < Base

      def to_json
        return nil if value.nil?
        value.to_bool
      end

    end
  end
end