require 'test_helper'

module PushType
  class Api::NodesControllerTest < ActionController::TestCase

    def node_attrs
      FactoryGirl.attributes_for :node, type: 'Page'
    end

    let(:node) { Page.create node_attrs }
    
    describe 'GET #index' do
      before :all do
        @parent = Page.create node_attrs
        5.times { Page.create node_attrs.merge(parent_id: @parent.id) }
      end
      describe 'with no scope' do
        before { get :index }
        it { response.must_respond_with :success }
        it { json_response['nodes'].size.must_equal 1 }
        it { json_response['meta'].must_be :present? }
        it { json_response['meta']['current_page'].must_equal 1 }
        it { json_response['meta']['child_nodes'].must_be_instance_of Array }
        it { json_response['meta']['child_nodes'].must_include 'page' }
      end
      describe 'with parent scope' do
        before { get :index, params: { node_id: @parent.id } }
        it { response.must_respond_with :success }
        it { json_response['nodes'].size.must_equal 5 }
      end
    end

    describe 'GET #trash' do
      before do
        2.times { FactoryGirl.create :node }
        3.times { FactoryGirl.create :node, deleted_at: Time.zone.now }
        get :trash
      end
      it { response.must_respond_with :success }
      it { json_response['nodes'].size.must_equal 3 }
      it { json_response['meta'].must_be :present? }
    end

    describe 'GET #show' do
      before { get :show, params: { id: node.id } }
      it { response.must_respond_with :success }
      it { json_response['node'].must_be :present? }
      it { json_response['node']['id'].must_equal node.id }
      it { json_response['meta'].must_be :present? }
      it { json_response['meta']['fields'].must_be_instance_of Array }
      it { json_response['meta']['child_nodes'].must_be_instance_of Array }
      it { json_response['meta']['child_nodes'].must_include 'page' }
    end

    describe 'POST #create' do
      before do
        @parent = FactoryGirl.create :node
        @count  = Page.count
      end
      describe 'with in-valid node' do
        before { post :create, params: { node: {} } }
        it { response.must_respond_with :unprocessable_entity }
        it { json_response['errors'].must_be :present? }
      end
      describe 'with valid node' do
        before { post :create, params: { node: node_attrs } }
        it { response.must_respond_with :created }
        it { json_response['node'].must_be :present? }
        it { json_response['node']['parent_id'].must_be :blank? }
        it { Page.count.must_equal @count + 1 }
      end
      describe 'with parent_scope' do
        before { post :create, params: { node: node_attrs.merge(parent_id: @parent.id) } }
        it { json_response['node']['parent_id'].must_equal @parent.id }
      end
    end

    describe 'PUT #update' do
      before { put :update, params: { id: node.id, node: { title: new_title } } }
      describe 'with in-valid node' do
        let(:new_title) { '' }
        it { response.must_respond_with :unprocessable_entity }
        it { json_response['errors']['title'].must_be :present? }
      end
      describe 'with valid node' do
        let(:new_title) { 'Foo bar baz' }
        it { response.must_respond_with :ok }
        it { json_response['node'].must_be :present? }
        it { json_response['node']['title'].must_equal new_title }
      end
    end

    describe 'DELETE #destroy' do
      describe 'with untrashed node' do
        before { delete :destroy, params: { id: node.id } }
        it { response.must_respond_with :ok }
        it { json_response['node'].must_be :present? }
        it { json_response['node']['is_trashed'].must_equal true }
        it { node.reload.must_be :trashed? }
      end
      describe 'with trashed node' do
        before do
          node.trash!
          delete :destroy, params: { id: node.id }
        end
        it { response.must_respond_with :no_content }
        it { response.body.must_be :blank? }
        it { proc { node.reload }.must_raise ActiveRecord::RecordNotFound }
      end
    end

    describe 'POST #position' do
      before do
        @first_node = FactoryGirl.create :node
        3.times { FactoryGirl.create :node }
        @last_node = FactoryGirl.create :node
      end
      describe 'reordering' do
        before { post :position, params: { id: @last_node.id, prev: @first_node.id } }
        it { response.must_respond_with :no_content }
        it { response.body.must_be :blank? }
      end
      describe 'without reponsitioning' do
        before { get :index }
        it { json_response['nodes'][0]['id'].must_equal @first_node.id }
        it { json_response['nodes'][-1]['id'].must_equal @last_node.id }
      end
      describe 'append node' do
        before do
          post :position, params: { id: @last_node.id, prev: @first_node.id }
          get :index
        end
        it { json_response['nodes'][0]['id'].must_equal @first_node.id }
        it { json_response['nodes'][1]['id'].must_equal @last_node.id }
      end
      describe 'prepend node' do
        before do
          post :position, params: { id: @last_node.id, next: @first_node.id }
          get :index
        end
        it { json_response['nodes'][1]['id'].must_equal @first_node.id }
        it { json_response['nodes'][0]['id'].must_equal @last_node.id }
      end
    end

    describe 'PUT #restore' do
      before do
        node.trash!
        put :restore, params: { id: node.id }
      end
      it { response.must_respond_with :ok }
      it { json_response['node'].must_be :present? }
      it { json_response['node']['is_trashed'].must_equal false }
      it { node.reload.wont_be :trashed? }
    end

    describe 'DELETE #empty' do
      before do
        3.times { FactoryGirl.create :node, deleted_at: Time.zone.now }
        delete :empty
      end
      it { response.must_respond_with :no_content }
      it { response.body.must_be :blank? }
      it { PushType::Node.trashed.must_be :empty? }
    end

  end
end
