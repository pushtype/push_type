module PushType
  module Fields
    module Arrays

      def param
        { json_key => [] }
      end

      def multiple?
        true
      end

      def to_json(val)
        Array(val)
      end

      def from_json(val)
        Array(val)
      end

    end
  end
end