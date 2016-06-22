require 'test_helper'

module PushType
  class Api::AssetsControllerTest < ActionController::TestCase

    let(:asset_attrs) { FactoryGirl.attributes_for(:asset) }
    let(:asset) { FactoryGirl.create :asset }
    
    describe 'GET #index' do
      before do
        5.times { FactoryGirl.create :asset }
        get :index
      end
      it { response.must_respond_with :success }
      it { json_response['assets'].size.must_equal 5 }
      it { json_response['meta'].must_be :present? }
      it { json_response['meta']['current_page'].must_equal 1 }
    end

    describe 'GET #trash' do
      before do
        2.times { FactoryGirl.create :asset }
        3.times { FactoryGirl.create :asset, deleted_at: Time.zone.now }
        get :trash
      end
      it { response.must_respond_with :success }
      it { json_response['assets'].size.must_equal 3 }
      it { json_response['meta'].must_be :present? }
    end

    describe 'GET #show' do
      before { get :show, params: { id: asset.id } }
      it { response.must_respond_with :success }
      it { json_response['asset'].must_be :present? }
      it { json_response['asset']['id'].must_equal asset.id }
    end

    describe 'POST #create' do
      before { @count = Asset.count }
      describe 'with in-valid asset' do
        before { post :create, params: { asset: {} } }
        it { response.must_respond_with :unprocessable_entity }
        it { json_response['errors'].must_be :present? }
      end
      describe 'with valid asset' do
        before { post :create, params: { asset: asset_attrs } }
        it { response.must_respond_with :created }
        it { json_response['asset'].must_be :present? }
        it { Asset.count.must_equal @count + 1 }
      end
    end

    describe 'PUT #update' do
      before { put :update, params: { id: asset.id, asset: { description: new_description } } }
      describe 'with valid asset' do
        let(:new_description) { 'Foo bar baz' }
        it { response.must_respond_with :ok }
        it { json_response['asset'].must_be :present? }
        it { json_response['asset']['description'].must_equal new_description }
      end
    end

    describe 'DELETE #destroy' do
      describe 'with untrashed asset' do
        before { delete :destroy, params: { id: asset.id } }
        it { response.must_respond_with :ok }
        it { json_response['asset'].must_be :present? }
        it { json_response['asset']['is_trashed'].must_equal true }
        it { asset.reload.must_be :trashed? }
      end
      describe 'with trashed asset' do
        before do
          asset.trash!
          delete :destroy, params: { id: asset.id }
        end
        it { response.must_respond_with :no_content }
        it { response.body.must_be :blank? }
        it { proc { asset.reload }.must_raise ActiveRecord::RecordNotFound }
      end
    end

    describe 'PUT #restore' do
      before do
        asset.trash!
        put :restore, params: { id: asset.id }
      end
      it { response.must_respond_with :ok }
      it { json_response['asset'].must_be :present? }
      it { json_response['asset']['is_trashed'].must_equal false }
      it { asset.reload.wont_be :trashed? }
    end

    describe 'DELETE #empty' do
      before do
        3.times { FactoryGirl.create :asset, deleted_at: Time.zone.now }
        delete :empty
      end
      it { response.must_respond_with :no_content }
      it { response.body.must_be :blank? }
      it { PushType::Asset.trashed.must_be :empty? }
    end

  end
end
