require 'test_helper'

module PushType
  class ConfirmationsControllerTest < ActionController::TestCase

    before { @request.env["devise.mapping"] = Devise.mappings[:user] }

    let(:user)  { FactoryGirl.create(:user) }
    let(:token) { user.confirmation_token }
    
    describe 'GET #show' do
      before { get :show, params: { confirmation_token: token } }
      describe 'with invalid confirmation token' do
        let(:token) { 'invalid' }
        it { response.must_render_template 'new' }
        it { assigns[:user].must_be :new_record? }
      end
      describe 'with valid confirmation token' do
        it { response.must_render_template 'show' }
        it { assigns[:user].must_equal user }
      end
    end

    describe 'PUT #update' do
      before { put :update, params: { user: { confirmation_token: token, password: password, password_confirmation: password } } }
      describe 'with invalid user' do
        let(:password) { '' }
        it { assigns[:user].errors.wont_be_empty }
        it { assigns[:user].wont_be :confirmed? }
        it { response.must_render_template :show }
      end
      describe 'with valid user' do
        let(:password) { 'pa$$word' }
        it { user.reload.must_be :confirmed? }
        it { response.must_respond_with :redirect }
      end
    end

  end
end
