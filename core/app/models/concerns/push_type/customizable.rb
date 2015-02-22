module PushType
  module Customizable
    extend ActiveSupport::Concern

    included do
      class_attribute :fields
      self.fields ||= ActiveSupport::OrderedHash.new
    end

    def fields
      self.class.fields
    end

    def field_params
      fields.map { |k, field| field.param }
    end

    module ClassMethods

      def field(name, *args)
        raise ArgumentError if args.size > 2
        kind, opts = case args.size
          when 2 then args
          when 1 then args[0].is_a?(Hash) ? args.insert(0, :string) : args.insert(-1, {})
          else        [ :string, {} ]
        end

        _field = self.fields[name] = field_factory(kind).new(name, opts)

        store_accessor :field_store, name
        validates name, opts[:validates] if opts[:validates]
        override_accessor _field

        if block = field_factory(kind).initialized_blk
          block.call(self, _field)
        end
      end

      protected

      def field_factory(kind)
        begin
          "push_type/#{ kind }_field".camelize.constantize
        rescue NameError
          "#{ kind }_field".camelize.constantize
        end
      end

      def override_accessor(f)
        define_method "#{f.name}=".to_sym do |val|
          super f.to_json(val)
        end
        define_method f.name do
          f.from_json super()
        end
      end

    end
  end
end