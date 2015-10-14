module PushType
  class MatrixField < PushType::FieldType

    options json_primitive: :array,
            template:       'matrix'

    def initialize(*args, &block)
      super
      structure_class.class_eval(&block) if block
      validate_field_types!
    end

    def value
      return if json_value.blank?
      json_value.map do |h|
        structure_class.new(field_store: h)
      end
    end

    def fields
      @fields ||= structure_class.new.fields
    end

    private

    def structure_class
      @structure_class ||= PushType::Structure.clone
    end

    def validate_field_types!
      fields.values.each do |f|
        kind = f.class.name.demodulize.underscore.gsub(/_(field|type)$/, '')
        unless field_type_whitelist.include?(kind.to_sym)
          raise ArgumentError, "Invalid field type. `#{ kind }` cannot be used in #{ self.class.name }."
        end
      end
    end

    def field_type_whitelist
      [:number, :string, :text]
    end

  end
end