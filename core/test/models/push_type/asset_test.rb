require "test_helper"

module PushType
  describe Asset do
    let(:asset) { Asset.new }

    it { asset.wont_be :valid? }
    it { asset.kind.must_equal nil }
    it { asset.description_or_file_name.must_equal nil }
    it { asset.preview_thumb_url.must_equal nil }

    it 'should be valid with required attributes' do
      asset.attributes = FactoryGirl.attributes_for :asset
      asset.must_be :valid?
    end

    describe '#kind' do
      let(:image) { FactoryGirl.create :image_asset }
      let(:audio) { FactoryGirl.create :audio_asset }
      let(:video) { FactoryGirl.create :video_asset }
      let(:doc)   { FactoryGirl.create :document_asset }
      it { image.kind.must_equal :image }
      it { image.must_be :image? }
      it { image.wont_be :audio? }
      it { image.wont_be :video? }
      it { audio.kind.must_equal :audio }
      it { audio.wont_be :image? }
      it { audio.must_be :audio? }
      it { audio.wont_be :video? }
      it { video.kind.must_equal :video }
      it { video.wont_be :image? }
      it { video.wont_be :audio? }
      it { video.must_be :video? }
      it { doc.kind.must_equal :document }
      it { doc.wont_be :image? }
      it { doc.wont_be :audio? }
      it { doc.wont_be :video? }
    end

    describe '#description_or_file_name' do
      let(:asset) { FactoryGirl.create :asset }
      it { asset.description_or_file_name.must_equal 'image.png' }
      it 'should return description when present' do
        asset.description = 'Foo bar'
        asset.description_or_file_name.must_equal 'Foo bar'
      end
    end

    describe '#preview_thumb_url' do
      let(:image) { FactoryGirl.create :image_asset }
      let(:doc)   { FactoryGirl.create :document_asset }
      it { image.preview_thumb_url.must_match %r{^/media/.*/image.png} }
      it { doc.preview_thumb_url.must_equal 'push_type/icon-file-document.png' }
    end

    describe '#set_mime_type' do
      let(:asset) { FactoryGirl.create :asset }
      it { asset.file_ext.must_equal 'png' }
      it { asset.mime_type.must_equal 'image/png' }
    end

  end
end
