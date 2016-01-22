module PushType
  class RepeaterField < FieldType

    options json_primitive: :array,
            repeats:        :string

    def initialize(*args)
      super
      raise ArgumentError, "Invalid field type. `#{ @opts[:repeats] }` cannot be used in #{ self.class.name }." if [:tag_list].include?(@opts[:repeats])
      _key, _opts = structure_json_key, @opts
      structure_class.class_eval do
        field _key, _opts[:repeats], _opts.except(:css_class, :repeats).merge(multiple: false)
        define_method(:f) { fields[_key] }
      end
    end

    def value
      return if json_value.blank?
      rows.reject(&:blank?).map(&:_f)
    end

    def template
      'repeater'
    end

    def rows
      Array(json_value).map do |j|
        structure_class.new(field_store: { structure_json_key => j }.as_json)
      end
    end

    def structure
      @structure ||= structure_class.new
    end

    private

    def defaults
      super.except(:template, :form_helper)
    end

    def structure_class
      @structure_class ||= PushType::Structure.clone
    end

    def structure_json_key
      case @opts[:repeats]
        when :relation, :asset then :_f_id
        else :_f
      end
    end

  end
end