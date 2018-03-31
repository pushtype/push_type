require 'test_helper'

module PushType
  class Admin::UsersControllerTest < ActionController::TestCase

    let(:user_attrs) { FactoryBot.attributes_for(:user) }
    let(:user) { FactoryBot.create :user }
    
    describe 'GET #index' do
      before do
        5.times { FactoryBot.create :user }
        get :index
      end
      it { response.must_render_template 'index' }
      it { assigns[:users].size.must_equal 5 }
    end

    describe 'GET #new' do
      before { get :new }
      it { response.must_render_template 'new' }
      it { assigns[:user].must_be :new_record? }
      it { assigns[:user].must_be_instance_of User }
    end

    describe 'POST #create' do
      let(:action!) { post :create, params: { user: user_attrs } }
      describe 'with valid user' do
        before { action! }
        it { response.must_respond_with :redirect }
        it { flash[:notice].must_be :present? }
      end
      describe 'user count' do
        it { proc { action! }.must_change 'User.count', 1 }
      end
      describe 'with in-valid user' do
        let(:user_attrs) { {} }
        before { action! }
        it { response.must_render_template 'new' }
        it { assigns[:user].errors.must_be :present? }
      end
    end

    describe 'GET #edit' do
      before { get :edit, params: { id: user.id } }
      it { response.must_render_template 'edit' }
      it { assigns[:user].must_equal user }
    end

    describe 'PUT #update' do
      before { put :update, params: { id: user.id, user: { name: new_name } } }
      describe 'with valid user' do
        let(:new_name) { 'Foo bar baz' }
        it { response.must_respond_with :redirect }
        it { flash[:notice].must_be :present? }
        it { user.reload.name.must_equal new_name }
      end
      describe 'with in-valid user' do
        let(:new_name) { '' }
        it { response.must_render_template 'edit' }
        it { assigns[:user].errors[:name].must_be :present? }
      end
    end

    describe 'DELETE #destroy' do
      before { delete :destroy, params: { id: user.id } }
      it { response.must_respond_with :redirect }
      it { flash[:notice].must_be :present? }
      it { proc { user.reload }.must_raise ActiveRecord::RecordNotFound }
    end

  end
end
