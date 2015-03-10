module PushType
  class Taxonomy < ActiveRecord::Base

    acts_as_tree name_column: 'slug', order: 'sort_order', dependent: :destroy

    validates :title, presence: true, uniqueness: { scope: :parent_id }
    validates :slug,  presence: true, uniqueness: { scope: :parent_id }

    class << self
      def termed(term)
        @term = term
      end

      def term
        ( @term || name ).to_s.underscore
      end
    end

    def term
      self.class.term
    end

    def permalink
      @permalink ||= self_and_ancestors.map(&:slug).push(term).reverse.join('/')
    end

  end
end
