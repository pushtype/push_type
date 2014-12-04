module PushType
  class DateField < PushType::FieldType
    def form_helper
      @opts[:form_helper] || :date_field
    end

    def from_json(val)
      val.to_date
    end
  end
end