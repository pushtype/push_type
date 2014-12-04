module PushType
  module Trashable
    extend ActiveSupport::Concern

    included do
      scope :not_trash, -> { where(deleted_at: nil) }
      scope :trashed,   -> { where('deleted_at IS NOT NULL') }
    end

    def trash!
      update_attribute :deleted_at, Time.zone.now
    end

    def restore!
      update_attribute :deleted_at, nil
    end

    def trashed?
      deleted_at.present?
    end

  end  
end