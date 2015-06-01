module PushType
  class NumberField < PushType::FieldType

    options form_helper: :number_field

    def to_json(val)
      val.to_i if val.present?
    end

  end
end