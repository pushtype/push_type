module PushType
  module Primitives
    class ObjectArrayType < Base

      def to_json
        unless value.blank?
          Array(value).reject { |v| v.blank? or v.values.all?(&:blank?) }
        end
      end

    end
  end
end

