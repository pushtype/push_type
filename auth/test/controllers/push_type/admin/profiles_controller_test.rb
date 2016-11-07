require 'test_helper'

module PushType
  class Admin::ProfilesControllerTest < ActionController::TestCase
    
    let(:current_user) { FactoryGirl.create(:confirmed_user) }
    before { sign_in current_user }

    describe 'GET #edit' do
      before { get :edit }
      it { response.must_render_template 'edit' }
      it { assigns[:user].must_equal current_user }
    end

    describe 'PUT #update' do
      before { put :update, params: { user: { name: new_name } } }

      describe 'with invalid user' do
        let(:new_name) { '' }
        it { assigns[:user].errors.wont_be_empty }
        it { response.must_render_template :edit }
      end

      describe 'with valid user' do
        let(:new_name) { 'Test user ABC' }
        it { current_user.reload.name.must_equal new_name }
        it { flash[:notice].must_be :present? }
        it { response.must_respond_with :redirect }
      end
    end

  end
end
