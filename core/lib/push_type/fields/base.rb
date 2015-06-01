module PushType
  module Fields
    module Base

      attr_reader :name      

      def initialize(name, opts = {})
        @name = name.to_s
        @opts = [defaults, self.class.options, opts].compact.inject(&:merge)
      end

      def kind
        self.class.kind
      end

      def json_key
        name.to_sym
      end

      def param
        json_key
      end

      def multiple?
        false
      end

      def template
        @opts[:template]
      end

      def label
        @opts[:label]
      end

      def html_options
        @opts[:html_options]
      end

      def form_helper
        @opts[:form_helper]
      end

      def to_json(val)
        val
      end

      def from_json(val)
        val
      end

      private

      def defaults
        {
          template:     'default',
          label:        name.humanize,
          form_helper:  :text_field,
          html_options: {}
        }
      end

    end
  end
end
