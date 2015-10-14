module PushType
  module Primitives
    class ArrayType < Base

      def to_json
        unless value.blank?
          Array(value).reject(&:blank?)
        end
      end

    end
  end
end

