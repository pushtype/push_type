require "test_helper"

module PushType
  describe FrontEndController do

    before { @routes = Rails.application.routes }
    
    describe 'GET #node' do
      let(:page)      { Page.create attributes }
      let(:permalink) { page.permalink }
      let(:action!)   { get :node, permalink: permalink }

      describe 'when node does not exist' do
        let(:permalink) { 'does/not/exist' }
        it { proc { action! }.must_raise ActiveRecord::RecordNotFound }
      end
      describe 'when node not published' do
        let(:attributes) { FactoryGirl.attributes_for :node, type: 'Page' }
        it { proc { action! }.must_raise ActiveRecord::RecordNotFound }
      end
      describe 'when node is published' do
        let(:attributes) { FactoryGirl.attributes_for :published_node, type: 'Page' }
        before { action! }
        it { response.must_render_template 'nodes/page' }
        it { assigns[:node].must_equal page }
        it { assigns[:page].must_equal page }
      end
    end

  end
end
