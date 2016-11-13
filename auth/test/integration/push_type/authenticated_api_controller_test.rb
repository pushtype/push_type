require 'test_helper'

class AuthenticatedApiControllerTest < ActionDispatch::IntegrationTest
  
  let(:current_user)  { FactoryGirl.create(:confirmed_user) }
  let(:auth_token)    { Knock::AuthToken.new(payload: { sub: current_user.id }).token }
  
  describe 'unauthenticated request' do
    before { get push_type_api.nodes_path }
    it { response.must_respond_with :unauthorized }
  end

  describe 'authenticated with authorization header' do
    before { get push_type_api.nodes_path, headers: { 'Authorization' => "JWT #{ auth_token }" } }
    it { response.must_respond_with :success }
  end

  describe 'authenticated with token param' do
    before { get push_type_api.nodes_path, params: { token: auth_token } }
    it { response.must_respond_with :success }
  end

end
