module PushType
  class Node < ActiveRecord::Base

    include PushType::Customizable
    include PushType::Nestable
    include PushType::Templatable
    include PushType::Unexposable
    include PushType::Publishable
    include PushType::Trashable
    include PushType::Presentable

    belongs_to :creator, class_name: 'PushType::User'
    belongs_to :updater, class_name: 'PushType::User'

    acts_as_tree name_column: 'slug', order: 'sort_order', dependent: :destroy

    validates :title, presence: true
    validates :slug,  presence: true, uniqueness: { scope: :parent_id }

    def permalink
      @permalink ||= self_and_ancestors.map(&:slug).reverse.join('/')
    end

    def orphan?
      parent && parent.trashed?
    end

    def trash!  
      super
      self.descendants.update_all deleted_at: Time.zone.now
    end
    
  end
end