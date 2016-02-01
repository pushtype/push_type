module PushType
  class WysiwygField < PushType::FieldType

    options template: 'wysiwyg'

    def form_helper
      :text_area
    end

    def html_options
      super.merge(class: 'froala')
    end
    
  end
end