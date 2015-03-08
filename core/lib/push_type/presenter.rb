module PushType
  class Presenter < SimpleDelegator

    attr_reader :model

    def initialize(model, view_context = nil)
      @model  = model
      @view   = view_context
      super(@model)
    end

    def helpers
      @view || raise("#{ self.class.name } initiated without view context.")
    end

    alias_method :h, :helpers

  end
end