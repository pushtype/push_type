module PushType
  module Publishable
    extend ActiveSupport::Concern

    included do
      enum status: [ :draft, :published ]

      scope :published, -> {
        not_trash
          .where(['push_type_nodes.status = ? AND push_type_nodes.published_at <= ?', self.statuses[:published], Time.zone.now])
          .where(['push_type_nodes.published_to IS NULL OR push_type_nodes.published_to > ?', Time.zone.now])
      }

      after_initialize :set_default_status
      before_save :set_published_at

      def published?
        super and !scheduled? and !expired?
      end
    end

    def scheduled?
      published_at? and published_at > Time.zone.now
    end

    def expired?
      published_to? and published_to < Time.zone.now
    end

    private

    def set_published_at
      case status
        when 'draft', self.class.statuses[:draft]         then self.published_at = nil
        when 'published', self.class.statuses[:published] then self.published_at ||= Time.zone.now
      end
    end

    def set_default_status
      self.status     ||= self.class.statuses[:draft]
    end

  end  
end