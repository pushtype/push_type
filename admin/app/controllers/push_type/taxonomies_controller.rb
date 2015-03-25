require_dependency "push_type/admin_controller"

module PushType
  class TaxonomiesController < AdminController
    
    def index
      @taxonomies = PushType.taxonomy_classes
    end

    def show
      @items = taxonomy.hash_tree.map { |parent, children| json_map(parent, children) }
    end

    private

    def initial_breadcrumb
      breadcrumbs.add 'Taxonomies', push_type.taxonomies_path
    end

    def taxonomy
      @taxonomy ||= PushType.taxonomy_classes.find { |t| t.name.underscore == params[:id] }
    end

    def json_map(parent, children)
      {
        id:         parent.id,
        title:      parent.title,
        slug:       parent.slug,
        sort_order: parent.sort_order,
        parent_id:  parent.parent_id,
        children:   children.map { |p, c| json_map(p, c) }
      }
    end

  end
end
