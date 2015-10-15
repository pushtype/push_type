module PushType
  module Primitives
    class NumberType < Base

      def to_json
        unless value.blank? || value.to_s !~ /^[\+\-]?\d+/
          (f = value.to_f) && (f % 1.0 == 0) ? f.to_i : f
        end
      end

    end
  end
end

