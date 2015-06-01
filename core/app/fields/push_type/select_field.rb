module PushType
  class SelectField < PushType::FieldType

    options template: 'select', choices: [], field_options: { include_blank: 'Please select...' }, multiple: false

    def multiple?
      @opts[:multiple]
    end

    def param
      multiple? ? { json_key => [] } : super
    end

    def choices
      if @opts[:choices].respond_to? :call
        @opts[:choices].call
      else
        @opts[:choices]
      end
    end

    def field_options
      @opts[:field_options]
    end

    def html_options
      super.merge(multiple: multiple?)
    end

    def to_json(val)
      return if val.blank?
      multiple? ? Array(val).reject(&:blank?) : super
    end

    def from_json(val)
      return if val.blank?
      multiple? ? Array(val).reject(&:blank?) : super
    end

  end
end