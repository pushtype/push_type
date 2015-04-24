module PushType
  class MultiSelectField < ArrayField

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
      super.merge(multiple: true)
    end

  end
end