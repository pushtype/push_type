module PushType
  class DateField < PushType::FieldType

    options template: 'date', form_helper: :date_field

    def from_json(val)
      val.to_date if val.present?
    end

  end
end