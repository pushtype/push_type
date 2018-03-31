require 'test_helper'

module PushType
  class AssetsHelperTest < ActionView::TestCase

    describe '#assets_array' do
      let(:assets)  { 4.times.map { FactoryBot.create :image_asset } }
      subject { assets_array(assets) }
      it { subject.must_be_instance_of Array }
      it { subject.first.must_be_instance_of Hash }
      it { subject.size.must_equal 4 }
    end

    describe '#asset_hash' do
      let(:asset) { FactoryBot.create :image_asset }
      subject { asset_hash(asset) }
      it { subject.must_be_instance_of Hash }
      it { subject.key?(:id).must_equal true }
      it { subject.key?(:file_name).must_equal true }
      it { subject.key?(:file_size).must_equal true }
      it { subject.key?(:mime_type).must_equal true }
      it { subject.key?(:created_at).must_equal true }
      it { subject.key?(:new_record?).must_equal true }
      it { subject.key?(:image?).must_equal true }
      it { subject.key?(:description_or_file_name).must_equal true }
      it { subject.key?(:preview_thumb_url).must_equal true }
    end

    describe '#asset_preview_thumb_url' do
      let(:image) { FactoryBot.create :image_asset }
      let(:doc) { FactoryBot.create :document_asset }
      it { asset_preview_thumb_url(image).must_match %r{^/media/.*} }
      it { asset_preview_thumb_url(doc).must_match %r{^/images/push_type/.*} }
    end

    describe '#asset_icon' do
      describe 'with image asset' do
        let(:asset) { FactoryBot.create :image_asset }
        it { asset_icon(asset).must_equal 'push_type/icons-assets.svg#image'}
      end
      describe 'with audio asset' do
        let(:asset) { FactoryBot.create :audio_asset }
        it { asset_icon(asset).must_equal 'push_type/icons-assets.svg#audio'}
      end
      describe 'with video asset' do
        let(:asset) { FactoryBot.create :video_asset }
        it { asset_icon(asset).must_equal 'push_type/icons-assets.svg#video'}
      end
      describe 'with document asset' do
        let(:asset) { FactoryBot.create :document_asset }
        it { asset_icon(asset).must_equal 'push_type/icons-assets.svg#pdf'}
      end
    end

  end
end
