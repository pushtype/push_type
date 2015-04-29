module PushType
  class RepeaterField < ArrayField
    
    def template
      @opts[:template] || :repeater
    end

    def to_json(val)
      return if val.blank?
      super.reject(&:blank?)
    end

    def from_json(val)
      return if val.blank?
      super.reject(&:blank?)
    end

  end
end