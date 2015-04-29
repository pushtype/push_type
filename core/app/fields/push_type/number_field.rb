module PushType
  class NumberField < PushType::FieldType
    def form_helper
      @opts[:form_helper] || :number_field
    end

    def to_json(val)
      return if val.blank?
      val.to_i
    end

    def from_json(val)
      return if val.blank?
      val.to_i
    end
  end
end