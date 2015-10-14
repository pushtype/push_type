module PushType
  class NumberField < PushType::FieldType

    options json_primitive: :number,
            form_helper:    :number_field

  end
end