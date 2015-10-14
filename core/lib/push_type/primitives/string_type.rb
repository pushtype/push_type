module PushType
  module Primitives
    class StringType < Base

      def to_json
        value.to_s unless value.blank?
      end

    end
  end
end

