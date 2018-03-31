require 'test_helper'

module PushType
  class Admin::NodesControllerTest < ActionController::TestCase

    let(:node_attrs) { FactoryBot.attributes_for(:node) }
    let(:node) { Page.create node_attrs }
    
    describe 'GET #index' do
      before do
        5.times { FactoryBot.create :node }
        get :index
      end
      it { response.must_render_template 'index' }
      it { assigns[:nodes].size.must_equal 5 }
    end

    describe 'GET #trash' do
      before do
        2.times { FactoryBot.create :node }
        3.times { FactoryBot.create :node, deleted_at: Time.zone.now }
        get :trash
      end
      it { response.must_render_template 'trash' }
      it { assigns[:nodes].size.must_equal 3 }
    end

    describe 'GET #new' do
      before { get :new, params: { kind: 'page' } }
      it { response.must_render_template 'new' }
      it { assigns[:node].must_be :new_record? }
      it { assigns[:node].must_be_instance_of Page }
    end

    describe 'POST #create' do
      let(:action!) { post :create, params: { kind: 'page', page: node_attrs } }
      describe 'with valid node' do
        before { action! }
        it { response.must_respond_with :redirect }
        it { flash[:notice].must_be :present? }
      end
      describe 'node count' do
        it { proc { action! }.must_change 'Page.count', 1 }
      end
      describe 'with in-valid node' do
        let(:node_attrs) { {} }
        before { action! }
        it { response.must_render_template 'new' }
        it { assigns[:node].errors.must_be :present? }
      end
    end

    describe 'GET #edit' do
      before { get :edit, params: { id: node.id } }
      it { response.must_render_template 'edit' }
      it { assigns[:node].must_equal node }
    end

    describe 'PUT #update' do
      before { put :update, params: { id: node.id, page: { title: new_title } } }
      describe 'with valid node' do
        let(:new_title) { 'Foo bar baz' }
        it { response.must_respond_with :redirect }
        it { flash[:notice].must_be :present? }
        it { node.reload.title.must_equal new_title }
      end
      describe 'with in-valid node' do
        let(:new_title) { '' }
        it { response.must_render_template 'edit' }
        it { assigns[:node].errors[:title].must_be :present? }
      end
    end

    describe 'DELETE #destroy' do
      describe 'with untrashed node' do
        before { delete :destroy, params: { id: node.id } }
        it { response.must_respond_with :redirect }
        it { flash[:notice].must_be :present? }
        it { node.reload.must_be :trashed? }
      end
      describe 'with trashed node' do
        before do
          node.trash!
          delete :destroy, params: { id: node.id }
        end
        it { response.must_respond_with :redirect }
        it { flash[:notice].must_be :present? }
        it { proc { node.reload }.must_raise ActiveRecord::RecordNotFound }
      end
    end

    describe 'POST #position' do
      before do
        @first_node = FactoryBot.create :node
        3.times { FactoryBot.create :node }
        @last_node = FactoryBot.create :node
      end
      describe 'without reponsitioning' do
        before { get :index }
        it { assigns[:nodes].first.must_equal @first_node }
        it { assigns[:nodes].last.must_equal @last_node }
      end
      describe 'append node' do
        before do
          post :position, params: { id: @last_node.id, prev: @first_node.id }
          get :index
        end
        it { assigns[:nodes].first.must_equal @first_node }
        it { assigns[:nodes][1].must_equal @last_node }
      end
      describe 'prepend node' do
        before do
          post :position, params: { id: @last_node.id, next: @first_node.id }
          get :index
        end
        it { assigns[:nodes][1].must_equal @first_node }
        it { assigns[:nodes].first.must_equal @last_node }
      end
    end

    describe 'PUT #restore' do
      before do
        node.trash!
        put :restore, params: { id: node.id }
      end
      it { response.must_respond_with :redirect }
      it { flash[:notice].must_be :present? }
      it { node.reload.wont_be :trashed? }
    end

    describe 'DELETE #empty' do
      before do
        3.times { FactoryBot.create :node, deleted_at: Time.zone.now }
        delete :empty
      end
      it { response.must_respond_with :redirect }
      it { flash[:notice].must_be :present? }
      it { PushType::Node.trashed.must_be :empty? }
    end

  end
end
