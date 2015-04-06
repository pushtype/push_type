module PushType
  class Taxonomy < ActiveRecord::Base

    include PushType::Templatable
    include PushType::Unexposable

    acts_as_tree name_column: 'slug', order: 'sort_order', dependent: :destroy

    validates :title, presence: true, uniqueness: { scope: :parent_id }
    validates :slug,  presence: true, uniqueness: { scope: :parent_id }

    class << self
      def title
        @title ||= name.underscore.humanize.pluralize
      end

      def base_slug(*args)
        if args.present?
          @base_slug = args.first
        else
          ( @base_slug || name ).to_s.underscore
        end
      end
    end

    def base_slug
      self.class.base_slug
    end

    def permalink
      @permalink ||= self_and_ancestors.map(&:slug).push(base_slug).reverse.join('/')
    end

    def exposed?
      self.class.exposed?
    end

  end
end
