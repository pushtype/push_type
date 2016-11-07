require 'test_helper'

class AuthenticatedControllerTest < ActionDispatch::IntegrationTest
  
  let(:current_user) { FactoryGirl.create(:confirmed_user, password: 'password', password_confirmation: 'password') }
  
  describe 'unauthenticated request' do
    before { get push_type_admin.nodes_path }
    it { response.must_redirect_to push_type_admin.new_user_session_path }
  end

  describe 'authenticated request' do
    before do
      post push_type_admin.user_session_path, params: { user: { email: current_user.email, password: 'password' } }
      get push_type_admin.nodes_path
    end
    it { response.must_respond_with :success }
  end

end
