require 'test_helper'

module PushType
  class AdminControllerTest < ActionController::TestCase
    
    describe 'GET #info' do
      before { get :info }
      it { response.must_render_template 'info' }
      it { response.must_render_template layout: false }
    end

  end
end
