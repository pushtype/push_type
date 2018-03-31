require 'test_helper'

class FrontEndControllerTest < ActionController::TestCase

  before { @routes = Rails.application.routes }

  describe 'GET #show' do
    let(:page)      { Page.create attributes }
    let(:permalink) { page.permalink }
    let(:action!)   { get :show, params: { permalink: permalink } }

    describe 'when node does not exist' do
      let(:permalink) { 'does/not/exist' }
      it { proc { action! }.must_raise ActiveRecord::RecordNotFound }
    end
    describe 'when node not published' do
      let(:attributes) { FactoryBot.attributes_for :node, type: 'Page' }
      it { proc { action! }.must_raise ActiveRecord::RecordNotFound }
    end
    describe 'when node is published' do
      let(:attributes) { FactoryBot.attributes_for :published_node, type: 'Page' }
      before { action! }
      it { response.must_render_template 'nodes/page' }
      it { assigns[:node].must_equal page }
      it { assigns[:page].must_equal page }
      it { assigns[:page].class.ancestors.must_include PushType::Presenter }
    end
  end

  describe 'GET #preview' do
    let(:page)      { Page.create FactoryBot.attributes_for(:node, type: 'Page') }
    let(:id)        { page.base64_id }
    let(:action!)   { get :preview, params: { id: id } }

    describe 'when node does not exist' do
      let(:id) { 'abcefg12345' }
      it { proc { action! }.must_raise ActiveRecord::RecordNotFound }
    end
    describe 'when node not published' do
      before { action! }
      it { response.must_render_template 'nodes/page' }
      it { response.headers.must_include 'X-Robots-Tag' }
      it { response.headers['X-Robots-Tag'].must_equal 'none' }
      it { assigns[:node].must_equal page }
      it { assigns[:page].must_equal page }
    end
  end

  describe 'node filters' do
    
    ApplicationController.module_eval do
      before_node_load { @foo = {} }
      before_node_action { @foo[:node_action] = true }
      before_node_action(only: :page) { @foo[:page_action] = true }
      before_node_action(only: :foo) { @foo[:foo_action] = true }
      before_node_action(except: :page) { @foo[:except_page_action] = true }
      before_node_action(except: :foo) { @foo[:except_foo_action] = true }
      before_node_action :test_1, :test_2
      private
      def test_1
        @foo[:test_1] = true
      end
      def test_2
        @foo[:test_2] = true
      end
    end

    let(:page) { FactoryBot.create :published_node, type: 'Page' }
    before { get :show, params: { permalink: page.permalink } }
    it { assigns[:foo].must_be_instance_of Hash }
    it { assigns[:foo][:node_action].must_equal true }
    it { assigns[:foo][:page_action].must_equal true }
    it { assigns[:foo][:foo_action].wont_be :present? }
    it { assigns[:foo][:except_page_action].wont_be :present? }
    it { assigns[:foo][:except_foo_action].must_equal true }
    it { assigns[:foo][:test_1].must_equal true }
    it { assigns[:foo][:test_2].must_equal true }
  end

end
