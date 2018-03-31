require 'test_helper'

module PushType
  class MediaUrlHelperTest < ActionView::TestCase

    let(:asset) { FactoryBot.create :asset }

    describe '#media_path' do
      it { media_path(asset).must_equal "/media/#{ asset.file_uid }" }
      it { media_path('test2.jpg').must_equal '/media/test2.jpg' }
    end

    describe '#media_url' do
      it { media_url(asset).must_equal "http://test.host/media/#{ asset.file_uid }" }
      it { media_url('test2.jpg').must_equal 'http://test.host/media/test2.jpg' }
    end

    describe 'with asset_host set' do      
      it '#media_path' do
        stub :compute_asset_host, 'https://cdn.test.host' do
          media_path(asset).must_equal "https://cdn.test.host/media/#{ asset.file_uid }"
        end
      end
      it '#media_url' do
        stub :compute_asset_host, 'https://cdn.test.host' do
          media_url(asset).must_equal "https://cdn.test.host/media/#{ asset.file_uid }"
        end
      end
    end

  end
end
