require_dependency "push_type/admin_controller"

module PushType
  class TaxonomyItemsController < AdminController

    before_filter :build_item, only: :create
    before_filter :load_item, only: [:update, :destroy, :position]

    def create
      respond_to do |format|
        if @item.save
          format.json { render json: @item, status: 201 }
        else
          format.json { render json: @item.errors, status: 422 }
        end
      end
    end

    def update
      respond_to do |format|
        if @item.update_attributes taxonomy_params
          format.json { head :ok }
        else
          format.json { render json: @item.errors, status: 422 }
        end
      end
    end

    def destroy
      respond_to do |format|
        format.json do
          @item.destroy
          head :ok
        end
      end
    end

    def position
      respond_to do |format|
        format.json do
          reorder_item
          head :ok
        end
      end
    end

    private

    def taxonomy
      @taxonomy ||= PushType.taxonomy_classes.find { |t| t.name.underscore == params[:taxonomy_id] }
    end

    def build_item
      @item = taxonomy.new taxonomy_params
    end

    def load_item
      @item = taxonomy.find params[:id]
    end

    def taxonomy_params
      params.fetch(taxonomy.name.underscore.to_sym, {}).permit(:id, :title, :slug)
    end

    def reorder_item
      if params[:prev]
        taxonomy.find(params[:prev]).append_sibling(@item)
      elsif params[:next]
        taxonomy.find(params[:next]).prepend_sibling(@item)
      elsif params[:parent]
        taxonomy.find(params[:parent]).append_child(@item)
      end
    end


  end
end
