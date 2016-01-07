module PushType
  class SelectField < PushType::FieldType

    options template:       'select',
            choices:        [], 
            field_options:  { include_blank: 'Please select...' }

    def choices
      if @opts[:choices].respond_to? :call
        model.instance_exec(&@opts[:choices])
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