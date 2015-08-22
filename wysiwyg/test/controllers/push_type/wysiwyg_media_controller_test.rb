require 'test_helper'

module PushType
  class WysiwygMediaControllerTest < ActionController::TestCase

    let(:json_response) { JSON.parse(response.body) }
    let(:asset_attrs)   { FactoryGirl.attributes_for(:asset) }
    
    describe 'GET #index' do
      before :all do
        5.times { FactoryGirl.create :image_asset }
        13.times { FactoryGirl.create :document_asset }
      end
      describe 'filtering for images' do
        before { get :index, format: :json, filter: 'image' }
        it { response.must_respond_with :success }
        it { json_response['assets'].size.must_equal 5 }
        it { json_response['meta']['current_page'].must_equal 1 }
        it { json_response['meta']['total_pages'].must_equal 1 }
      end
      describe 'filtering for files' do
        before { get :index, format: :json, filter: 'file' }
        it { response.must_respond_with :success }
        it { json_response['assets'].size.must_equal 12 }
        it { json_response['meta']['current_page'].must_equal 1 }
        it { json_response['meta']['total_pages'].must_equal 2 }
      end
      describe 'with pagination' do
        before { get :index, format: :json, filter: 'file', page: 2 }
        it { response.must_respond_with :success }
        it { json_response['assets'].size.must_equal 1 }
        it { json_response['meta']['current_page'].must_equal 2 }
        it { json_response['meta']['total_pages'].must_equal 2 }
      end
    end

    describe 'POST #create' do
      let(:action!) { post :create, format: :json, asset: asset_attrs }
      describe 'with valid asset' do
        before { action! }
        it { response.must_respond_with :success }
        it { json_response['link'].must_be :present? }
        it { json_response['error'].wont_be :present? }
      end
      describe 'asset count' do
        it { proc { action! }.must_change 'Asset.count', 1 }
      end
      describe 'with in-valid asset' do
        let(:asset_attrs) { {} }
        before { action! }
        it { response.must_respond_with :success }
        it { json_response['link'].wont_be :present? }
        it { json_response['error'].must_be :present? }
      end
    end

  end
end
