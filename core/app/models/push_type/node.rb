module PushType
  class Node < ActiveRecord::Base

    include PushType::Customizable
    include PushType::Nestable
    include PushType::Templatable
    #include PushType::Publishable
    include PushType::Trashable

    belongs_to :creator, class_name: 'PushType::User'
    belongs_to :updater, class_name: 'PushType::User'

    enum status: [ :draft, :published ]

    acts_as_tree name_column: 'slug', order: 'sort_order'

    validates :title, presence: true
    validates :slug,  presence: true, uniqueness: { scope: :parent_id }

    scope :published, -> {
      not_trash.where(['push_type_nodes.status = ? AND push_type_nodes.published_at <= ?', Node.statuses[:published], Time.zone.now]).
        where(['push_type_nodes.published_to IS NULL OR push_type_nodes.published_to > ?', Time.zone.now])
    }

    after_initialize :default_values
    before_save :set_published_at

    def permalink
      @permalink ||= self_and_ancestors.map(&:slug).reverse.join('/')
    end

    def published?
      super and !scheduled? and !expired?
    end

    def scheduled?
      published_at? and published_at > Time.zone.now
    end

    def expired?
      published_to? and published_to < Time.zone.now
    end

    private

    def default_values
      self.status ||= Node.statuses[:draft]
    end

    def set_published_at
      case status
        when 'draft', Node.statuses[:draft]         then self.published_at = nil
        when 'published', Node.statuses[:published] then self.published_at ||= Time.zone.now
      end
    end
    
  end
end