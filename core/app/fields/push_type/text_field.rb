module PushType
  class TextField < PushType::FieldType
    def form_helper
      @opts[:form_helper] || :text_area
    end
  end
end