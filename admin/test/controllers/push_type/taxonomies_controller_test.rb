require "test_helper"

module PushType
  describe TaxonomiesController do
    
    describe 'GET #index' do
      before { get :index }
      it { response.must_render_template 'index' }
      it { assigns[:taxonomies].size.must_equal 1 }
      it { assigns[:taxonomies].first.must_equal Category }
    end

    describe 'GET #show' do
      before do
        3.times { @parent = FactoryGirl.create :taxonomy, type: 'Category' }
        @child  = FactoryGirl.create :taxonomy, type: 'Category', parent: @parent
        get :show, id: 'category'
      end
      it { response.must_render_template 'show' }
      it { assigns[:terms].size.must_equal 3 }
      it { assigns[:terms].map { |h| h[:children] }.flatten.size.must_equal 1 }
    end

  end
end
