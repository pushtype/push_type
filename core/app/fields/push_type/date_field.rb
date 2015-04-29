module PushType
  class DateField < PushType::FieldType

    def template
      @opts[:template] || 'date'
    end

    def form_helper
      @opts[:form_helper] || :date_field
    end

    def from_json(val)
      return if val.blank?
      val.to_date
    end

  end
end