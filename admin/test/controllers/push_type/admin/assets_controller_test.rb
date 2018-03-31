require 'test_helper'

module PushType
  class Admin::AssetsControllerTest < ActionController::TestCase

    let(:asset_attrs) { FactoryBot.attributes_for(:asset) }
    let(:asset) { FactoryBot.create :asset }
    
    describe 'GET #index' do
      before do
        5.times { FactoryBot.create :asset }
        get :index
      end
      it { response.must_render_template 'index' }
      it { assigns[:assets].size.must_equal 5 }
    end

    describe 'GET #trash' do
      before do
        2.times { FactoryBot.create :asset }
        3.times { FactoryBot.create :asset, deleted_at: Time.zone.now }
        get :trash
      end
      it { response.must_render_template 'trash' }
      it { assigns[:assets].size.must_equal 3 }
    end

    describe 'GET #new' do
      before { get :new }
      it { response.must_render_template 'new' }
      it { assigns[:asset].must_be :new_record? }
      it { assigns[:asset].must_be_instance_of Asset }
    end

    describe 'POST #create' do
      let(:action!) { post :create, params: { asset: asset_attrs } }
      describe 'with valid asset' do
        before { action! }
        it { response.must_respond_with :redirect }
        it { flash[:notice].must_be :present? }
      end
      describe 'asset count' do
        it { proc { action! }.must_change 'Asset.count', 1 }
      end
      describe 'with in-valid asset' do
        let(:asset_attrs) { {} }
        before { action! }
        it { response.must_render_template 'new' }
        it { assigns[:asset].errors.must_be :present? }
      end
    end

    describe 'POST #upload' do
      let(:json_response) { JSON.parse(response.body) }
      let(:action!) { post :upload, format: :json, params: { asset: asset_attrs } }
      describe 'with valid asset' do
        before { action! }
        it { response.must_respond_with :success }
        it { json_response['asset'].must_be :present? }
        it { json_response['errors'].wont_be :present? }
      end
      describe 'asset count' do
        it { proc { action! }.must_change 'Asset.count', 1 }
      end
      describe 'with in-valid asset' do
        let(:asset_attrs) { {} }
        before { action! }
        it { response.must_respond_with :unprocessable_entity }
        it { json_response['asset'].wont_be :present? }
        it { json_response['errors'].must_be :present? }
      end
    end

    describe 'GET #edit' do
      before { get :edit, params: { id: asset.id } }
      it { response.must_render_template 'edit' }
      it { assigns[:asset].must_equal asset }
    end

    describe 'PUT #update' do
      before { put :update, params: { id: asset.id, asset: { description: new_description } } }
      describe 'with valid asset' do
        let(:new_description) { 'Foo bar baz' }
        it { response.must_respond_with :redirect }
        it { flash[:notice].must_be :present? }
        it { asset.reload.description.must_equal new_description }
      end
    end

    describe 'DELETE #destroy' do
      before { delete :destroy, params: { id: asset.id } }
      it { response.must_respond_with :redirect }
      it { flash[:notice].must_be :present? }
      it { asset.reload.must_be :trashed? }
    end

    describe 'PUT #restore' do
      before do
        asset.trash!
        put :restore, params: { id: asset.id }
      end
      it { response.must_respond_with :redirect }
      it { flash[:notice].must_be :present? }
      it { asset.reload.wont_be :trashed? }
    end

    describe 'DELETE #empty' do
      before do
        3.times { FactoryBot.create :asset, deleted_at: Time.zone.now }
        delete :empty
      end
      it { response.must_respond_with :redirect }
      it { flash[:notice].must_be :present? }
      it { PushType::Asset.trashed.must_be :empty? }
    end

  end
end
