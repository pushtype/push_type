module PushType
  class TimeField < PushType::FieldType

    options template: 'date', form_helper: :time_field

    def from_json(val)
      val.to_time if val.present?
    end
    
  end
end