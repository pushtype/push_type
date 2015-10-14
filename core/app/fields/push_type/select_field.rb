module PushType
  class SelectField < PushType::FieldType

    options template:       'select',
            form_helper:    :select,
            choices:        [], 
            field_options:  { include_blank: 'Please select...' },
            multiple:       false

    def choices
      if @opts[:choices].respond_to? :call
        @opts[:choices].call
      else
        @opts[:choices]
      end
    end

    def multiple?
      @opts[:multiple]
    end

    def json_primitive
       multiple? ? :array : super 
    end

    def html_options
      @opts[:html_options].merge(multiple: multiple?)
    end

  end
end