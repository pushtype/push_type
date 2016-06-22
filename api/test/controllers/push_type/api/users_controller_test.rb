require 'test_helper'

module PushType
  class Api::UsersControllerTest < ActionController::TestCase

    let(:user_attrs) { FactoryGirl.attributes_for(:user) }
    let(:user) { FactoryGirl.create :user }
    
    describe 'GET #index' do
      before do
        5.times { FactoryGirl.create :user }
        get :index
      end
      it { response.must_respond_with :success }
      it { json_response['users'].size.must_equal 5 }
      it { json_response['meta'].must_be :present? }
      it { json_response['meta']['current_page'].must_equal 1 }
    end

    describe 'GET #show' do
      before { get :show, params: { id: user.id } }
      it { response.must_respond_with :success }
      it { json_response['user'].must_be :present? }
      it { json_response['user']['id'].must_equal user.id }
      it { json_response['meta'].must_be :present? }
      it { json_response['meta']['fields'].must_be_instance_of Array }
    end

    describe 'POST #create' do
      before { @count = Asset.count }
      describe 'with in-valid user' do
        before { post :create, params: { user: {} } }
        it { response.must_respond_with :unprocessable_entity }
        it { json_response['errors'].must_be :present? }
      end
      describe 'with valid user' do
        before { post :create, params: { user: user_attrs } }
        it { response.must_respond_with :created }
        it { json_response['user'].must_be :present? }
        it { User.count.must_equal @count + 1 }
      end
    end

    describe 'PUT #update' do
      before { put :update, params: { id: user.id, user: { name: new_name } } }
      describe 'with in-valid user' do
        let(:new_name) { '' }
        it { response.must_respond_with :unprocessable_entity }
        it { json_response['errors']['name'].must_be :present? }
      end
      describe 'with valid user' do
        let(:new_name) { 'Foo bar baz' }
        it { response.must_respond_with :ok }
        it { json_response['user'].must_be :present? }
        it { json_response['user']['name'].must_equal new_name }
      end
    end

    describe 'DELETE #destroy' do
      before { delete :destroy, params: { id: user.id } }
      it { response.must_respond_with :no_content }
      it { response.body.must_be :blank? }
      it { proc { user.reload }.must_raise ActiveRecord::RecordNotFound }
    end

  end
end
