require "test_helper"

module PushType
  describe TaxonomyTermsController do

    let(:json_response) { JSON.parse(response.body) }
  
    describe 'POST #create' do
      let(:taxonomy_attrs) { FactoryGirl.attributes_for :taxonomy }
      let(:action!) { post :create, format: :json, taxonomy_id: 'category', category: taxonomy_attrs }
      describe 'with valid taxonomy' do
        before { action! }
        it { response.must_respond_with :success }
        it { json_response['term'].must_be :present? }
      end
      describe 'taxonomy count' do
        it { proc { action! }.must_change 'Category.count', 1 }
      end
      describe 'with in-valid taxonomy' do
        let(:taxonomy_attrs) { {} }
        before { action! }
        it { response.must_respond_with :unprocessable_entity }
        it { json_response['errors'].must_be :present? }
      end
    end

    describe 'PUT #update' do
      let(:category) { FactoryGirl.create :taxonomy, type: 'Category' }
      before { put :update, format: :json, taxonomy_id: 'category', id: category.id, category: { title: new_title } }
      describe 'with valid taxonomy' do
        let(:new_title) { 'Foo bar baz' }
        it { response.must_respond_with :success }
        it { category.reload.title.must_equal new_title }
      end
      describe 'with in-valid taxonomy' do
        let(:new_title) { '' }
        it { response.must_respond_with :unprocessable_entity }
        it { json_response['errors'].must_be :present? }
      end
    end

    describe 'DELETE #destroy' do
      let(:category) { FactoryGirl.create :taxonomy, type: 'Category' }
      before { delete :destroy, format: :json, taxonomy_id: 'category', id: category.id }
      it { response.must_respond_with :success }
      it { proc { category.reload }.must_raise ActiveRecord::RecordNotFound }
    end

    describe 'PUT #position' do
      let(:terms) { Category.roots.all }
      before do
        @first_node = Category.create FactoryGirl.attributes_for(:taxonomy)
        3.times { Category.create FactoryGirl.attributes_for(:taxonomy) }
        @last_node = Category.create FactoryGirl.attributes_for(:taxonomy)
      end
      describe 'without reponsitioning' do
        it { terms.first.must_equal @first_node }
        it { terms.last.must_equal @last_node }
      end
      describe 'append sibling' do
        before do
          post :position, format: :json, taxonomy_id: 'category', id: @last_node.id, prev: @first_node.id
        end
        it { terms.first.must_equal @first_node }
        it { terms[1].must_equal @last_node }
      end
      describe 'prepend sibling' do
        before do
          post :position, format: :json, taxonomy_id: 'category', id: @last_node.id, next: @first_node.id
        end
        it { terms[1].must_equal @first_node }
        it { terms.first.must_equal @last_node }
      end
      describe 'append child' do
        before do
          post :position, format: :json, taxonomy_id: 'category', id: @last_node.id, parent: @first_node.id
        end
        it { terms.first.must_equal @first_node }
        it { terms.first.children.must_include @last_node }
      end
    end

  end
end
