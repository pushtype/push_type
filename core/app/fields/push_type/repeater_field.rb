module PushType
  class RepeaterField < FieldType

    include PushType::Fields::Arrays

    options template: :repeater

    def to_json(val)
      super.reject(&:blank?) if val.present?
    end

    def from_json(val)
      super.reject(&:blank?) if val.present?
    end

  end
end