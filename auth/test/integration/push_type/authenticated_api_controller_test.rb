require 'test_helper'

class AuthenticatedApiControllerTest < ActionDispatch::IntegrationTest
  
  let(:current_user) { FactoryGirl.create(:confirmed_user) }
  
  describe 'unauthenticated request' do
    before { get api_nodes_path }
    it { response.must_respond_with :unauthorized }
  end

  describe 'authenticated request' do
    before { get api_nodes_path, headers: { 'X-User-Email' => current_user.email, 'X-User-Token' => current_user.authentication_token } }
    it { response.must_respond_with :success }
  end

end
