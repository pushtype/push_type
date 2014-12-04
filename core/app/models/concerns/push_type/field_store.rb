module PushType
  module FieldStore
    extend ActiveSupport::Concern

    def fields
      self.class.fields
    end

    module ClassMethods

      attr_reader :fields

      def fields
        @fields ||= ActiveSupport::OrderedHash.new
      end

      def field(name, *args)
        raise ArgumentError if args.size > 2
        kind, opts = case args.size
          when 2 then args
          when 1 then args[0].is_a?(Hash) ? args.insert(0, :string) : args.insert(-1, {})
          else        [ :string, {} ]
        end

        fields[name] = field_factory(kind).new(name, opts)
        store_accessor :field_store, name

        validates name, opts[:validates] if opts[:validates]
        
        override_accessor fields[name]
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
          return unless val
          super f.to_json(val)
        end
        define_method f.name do
          return unless val = super()
          f.from_json val
        end
      end

    end
  end
end