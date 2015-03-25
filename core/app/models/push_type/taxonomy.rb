module PushType
  class Taxonomy < ActiveRecord::Base

    acts_as_tree name_column: 'slug', order: 'sort_order', dependent: :destroy

    validates :title, presence: true, uniqueness: { scope: :parent_id }
    validates :slug,  presence: true, uniqueness: { scope: :parent_id }

    class << self
      def update_or_create(params)
        new_params = params.select { |t| t[:id].nil? }
        upd_params = params.select { |t| t[:id].present? }
        transaction do
          create(new_params) +
            update(upd_params.map(&:id), upd_params.map { |p| p.except(:id) })
        end
      end

      def title
        @title ||= name.underscore.humanize.pluralize
      end

      def termed(term)
        @term = term
      end

      def term
        ( @term || name ).to_s.underscore
      end

      def unexpose!
        PushType.config.unexposed_taxonomies.push(self.name.underscore.to_sym).uniq!
      end

      def exposed?
        !PushType.unexposed_taxonomies.include?(self.name.underscore)
      end
    end

    def term
      self.class.term
    end

    def permalink
      @permalink ||= self_and_ancestors.map(&:slug).push(term).reverse.join('/')
    end

    def exposed?
      self.class.exposed?
    end

  end
end
