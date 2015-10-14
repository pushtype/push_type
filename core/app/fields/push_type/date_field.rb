module PushType
  class DateField < PushType::FieldType

    options template:     'date',
            form_helper:  :date_field

    def value
      json_value.to_date unless json_value.blank?
    end

  end
end