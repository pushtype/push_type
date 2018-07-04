module PushType
  class WysiwygField < PushType::FieldType

    FROALA_KEY = 'MC1A1E1sB4E4B3A11B3A7E7F2E4B3fTYPASIBGMWC1YLMP=='

    options template: 'wysiwyg', toolbar: 'full'

    def form_helper
      :text_area
    end

    def toolbar
      @opts[:toolbar]
    end

    def html_options
      super.merge(:'v-froala' => true, :'froala-toolbar' => toolbar)
    end
    
  end
end