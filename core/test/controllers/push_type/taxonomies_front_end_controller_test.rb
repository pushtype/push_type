require "test_helper"

module PushType
  describe TaxonomiesFrontEndController do

    before { @routes = Rails.application.routes }
    
    describe 'GET #show' do
      let(:category)  { Category.create FactoryGirl.attributes_for(:taxonomy) }
      let(:taxonomy)  { category.base_slug }
      let(:permalink) { category.slug }
      let(:action!)   { get :show, taxonomy: taxonomy, permalink: permalink }

      describe 'when taxonomy class does not exist' do
        let(:taxonomy) { 'noop' }
        it { proc { action! }.must_raise ActiveRecord::RecordNotFound }
      end
      describe 'when taxonomy term does not exist' do
        let(:permalink) { 'does/not/exist' }
        it { proc { action! }.must_raise ActiveRecord::RecordNotFound }
      end
      describe 'when taxonomy term does exist' do
        before { action! }
        it { response.must_render_template 'taxonomies/category' }
        it { assigns[:taxonomy].must_equal category }
        it { assigns[:category].must_equal category }
      end
    end

    describe 'taxonomy filters' do
      ApplicationController.module_eval do
        before_taxonomy_load { @foo = {} }
        before_taxonomy_action { @foo[:taxonomy_action] = true }
        before_taxonomy_action(only: :category) { @foo[:category_action] = true }
        before_taxonomy_action(only: :foo) { @foo[:foo_action] = true }
        before_taxonomy_action(except: :category) { @foo[:except_category_action] = true }
        before_taxonomy_action(except: :foo) { @foo[:except_foo_action] = true }
        before_taxonomy_action :test_1, :test_2
        private
        def test_1
          @foo[:test_1] = true
        end
        def test_2
          @foo[:test_2] = true
        end
      end
      let(:category)  { Category.create FactoryGirl.attributes_for(:taxonomy) }
      before { get :show, taxonomy: category.base_slug, permalink: category.slug }
      it { assigns[:foo].must_be_instance_of Hash }
      it { assigns[:foo][:taxonomy_action].must_equal true }
      it { assigns[:foo][:category_action].must_equal true }
      it { assigns[:foo][:foo_action].wont_be :present? }
      it { assigns[:foo][:except_category_action].wont_be :present? }
      it { assigns[:foo][:except_foo_action].must_equal true }
      it { assigns[:foo][:test_1].must_equal true }
      it { assigns[:foo][:test_2].must_equal true }
    end

  end
end
