module PushType
  module Primitives
    class ObjectType < Base

      def to_json
        unless value.blank? or value.values.all?(&:blank?)
          super
        end
      end

    end
  end
end

