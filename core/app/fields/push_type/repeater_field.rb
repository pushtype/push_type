module PushType
  class RepeaterField < FieldType

    options json_primitive: :array,
            repeats:        :string

    def initialize(*args)
      super
      validate_field_type!
    end

    def value
      return if json_value.blank?
      json_value.map do |j|
        generate_field('_f' => j).value
      end
    end

    def template
      'repeater'
    end

    def field
      @field ||= generate_field
    end

    private

    def defaults
      super.except(:template, :form_helper)
    end

    def generate_field(json = {})
      field_type.new :_f, PushType::Structure.new(field_store: json), @opts.except(:css_class).merge(multiple: false)
    end

    def field_type
      begin
        "push_type/#{ @opts[:repeats] }_field".camelize.constantize
      rescue NameError
        "#{ @opts[:repeats] }_field".camelize.constantize
      end
    end

    def validate_field_type!
      unless field_type_whitelist.include?(@opts[:repeats])
        raise ArgumentError, "Invalid field type. `#{ @opts[:repeats] }` cannot be used in #{ self.class.name }."
      end
    end

    def field_type_whitelist
      [:number, :string, :text]
    end

  end
end