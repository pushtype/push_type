module PushType
  class SelectField < PushType::FieldType

    def param
      multiple? ? { name.to_sym => [] } : super
    end

    def template
      @opts[:template] || 'select'
    end

    def choices
      return [] unless @opts[:choices]
      if @opts[:choices].respond_to? :call
        @opts[:choices].call
      else
        @opts[:choices]
      end
    end

    def field_options
      { include_blank: 'Please select...' }.merge(@opts[:field_options] || {})
    end

    def html_options
      super.merge(multiple: multiple?)
    end

    def to_json(val)
      return unless val
      multiple? ? Array(val).reject(&:blank?) : super
    end

    def from_json(val)
      return unless val
      multiple? ? Array(val).reject(&:blank?) : super
    end

    def multiple?
      @opts[:multiple] || false
    end

  end
end