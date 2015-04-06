require_dependency "push_type/admin_controller"

module PushType
  class TaxonomyTermsController < AdminController

    before_filter :build_term, only: :create
    before_filter :load_term, only: [:update, :destroy, :position]

    def create
      respond_to do |format|
        format.json do
          if @term.save
            render json: { term: @term.as_json }, status: :created
          else
            render json: { errors: @term.errors }, status: :unprocessable_entity
          end
        end
      end
    end

    def update
      respond_to do |format|
        format.json do
          if @term.update_attributes taxonomy_params
            head :ok
          else
            render json: { errors: @term.errors }, status: :unprocessable_entity
          end
        end
      end
    end

    def destroy
      respond_to do |format|
        format.json do
          @term.destroy
          head :ok
        end
      end
    end

    def position
      respond_to do |format|
        format.json do
          reorder_term
          head :ok
        end
      end
    end

    private

    def taxonomy
      @taxonomy ||= PushType::Taxonomy.descendants.find { |t| t.name.underscore == params[:taxonomy_id] }
    end

    def build_term
      @term = taxonomy.new taxonomy_params
    end

    def load_term
      @term = taxonomy.find params[:id]
    end

    def taxonomy_params
      params.fetch(taxonomy.name.underscore.to_sym, {}).permit(:id, :title, :slug)
    end

    def reorder_term
      if params[:prev]
        taxonomy.find(params[:prev]).append_sibling(@term)
      elsif params[:next]
        taxonomy.find(params[:next]).prepend_sibling(@term)
      elsif params[:parent]
        taxonomy.find(params[:parent]).append_child(@term)
      end
    end


  end
end
