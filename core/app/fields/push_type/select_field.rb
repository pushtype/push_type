module PushType
  class SelectField < PushType::FieldType

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

  end
end