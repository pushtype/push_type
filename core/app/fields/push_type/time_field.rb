module PushType
  class TimeField < PushType::FieldType

    options template:     'date',
            form_helper:  :time_field

    def value
      json_value.to_time unless json_value.blank?
    end
    
  end
end