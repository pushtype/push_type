module PushType
  module Fields
    module ClassMethods

      attr_reader :initialized_blk

      def options(*opts)
        @options ||= opts.first
      end

      def initialized_on_node(&block)
        @initialized_blk = block
      end

      def kind
        self.name.demodulize.underscore.gsub(/_(field|type)$/, '')
      end

    end
  end
end
