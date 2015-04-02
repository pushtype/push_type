module PushType
  class TaxonomiesFrontEndController < FrontEndController

    before_action :load_taxonomy, only: :show
    hooks_for :taxonomy, only: :show

    def show
      render *@taxonomy.template_args
    end

    private

    def load_taxonomy
      @taxonomy = taxonomy_class.find_by_path(permalink_path)
      if @taxonomy
        instance_variable_set "@#{ @taxonomy.type.underscore }", @taxonomy
      else
        raise_404
      end
    end

    def taxonomy_class
      PushType::Taxonomy.descendants(exposed: true).find { |t| t.base_slug == params[:taxonomy] } or raise_404
    end

  end
end
