require "test_helper"

module PushType
  describe AssetsHelper do

    describe '#asset_icon' do
      describe 'with image asset' do
        let(:asset) { FactoryGirl.create :image_asset }
        it { asset_icon(asset).must_equal 'push_type/icon-file-image.png'}
      end
      describe 'with audio asset' do
        let(:asset) { FactoryGirl.create :audio_asset }
        it { asset_icon(asset).must_equal 'push_type/icon-file-audio.png'}
      end
      describe 'with video asset' do
        let(:asset) { FactoryGirl.create :video_asset }
        it { asset_icon(asset).must_equal 'push_type/icon-file-video.png'}
      end
      describe 'with document asset' do
        let(:asset) { FactoryGirl.create :document_asset }
        it { asset_icon(asset).must_equal 'push_type/icon-file-document.png'}
      end
    end

  end
end
