require 'test_helper'

module PushType
  class AssetTest < ActiveSupport::TestCase
    let(:asset) { Asset.new }

    it { asset.wont_be :valid? }
    it { asset.kind.must_be_nil }
    it { asset.description_or_file_name.must_be_nil }
    it { asset.preview_thumb.must_be_nil }

    it 'should be valid with required attributes' do
      asset.attributes = FactoryBot.attributes_for :asset
      asset.must_be :valid?
    end

    describe '#kind' do
      let(:image) { FactoryBot.create :image_asset }
      let(:audio) { FactoryBot.create :audio_asset }
      let(:video) { FactoryBot.create :video_asset }
      let(:doc)   { FactoryBot.create :document_asset }
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
      it { doc.kind.must_equal :pdf }
      it { doc.wont_be :image? }
      it { doc.wont_be :audio? }
      it { doc.wont_be :video? }

      describe 'documents' do
        let(:asset) { PushType::Asset.new }
        it 'should detect modern word docs' do
          asset.mime_type = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
          asset.stub(:file_stored?, true) { asset.kind.must_equal :doc }
        end
        it 'should detect modern legacy word docs' do
          asset.mime_type = 'application/vnd.msword'
          asset.stub(:file_stored?, true) { asset.kind.must_equal :doc }
        end
        it 'should detect plain text files' do
          asset.mime_type = 'text/plain'
          asset.stub(:file_stored?, true) { asset.kind.must_equal :doc }
        end
        it 'should detect rich text files' do
          asset.mime_type = 'text/rtf'
          asset.stub(:file_stored?, true) { asset.kind.must_equal :doc }
        end
      end

      describe 'spreadsheets' do
        let(:asset) { PushType::Asset.new }
        it 'should detect modern excel docs' do
          asset.mime_type = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
          asset.stub(:file_stored?, true) { asset.kind.must_equal :sheet }
        end
        it 'should detect modern legacy excel docs' do
          asset.mime_type = 'application/vnd.ms-excel'
          asset.stub(:file_stored?, true) { asset.kind.must_equal :sheet }
        end
      end

      describe 'presentations' do
        let(:asset) { PushType::Asset.new }
        it 'should detect modern excel docs' do
          asset.mime_type = 'application/vnd.openxmlformats-officedocument.presentationml.presentation'
          asset.stub(:file_stored?, true) { asset.kind.must_equal :slides }
        end
        it 'should detect modern legacy excel docs' do
          asset.mime_type = 'application/vnd.ms-powerpoint'
          asset.stub(:file_stored?, true) { asset.kind.must_equal :slides }
        end
      end

      describe 'code' do
        let(:asset) { PushType::Asset.new }
        it 'should detect html' do
          asset.mime_type = 'text/html'
          asset.stub(:file_stored?, true) { asset.kind.must_equal :code }
        end
        it 'should detect javascript' do
          asset.mime_type = 'text/javascript'
          asset.stub(:file_stored?, true) { asset.kind.must_equal :code }
        end
        it 'should detect xml' do
          asset.mime_type = 'application/xml'
          asset.stub(:file_stored?, true) { asset.kind.must_equal :code }
        end
      end
    end

    describe '#description_or_file_name' do
      let(:asset) { FactoryBot.create :asset }
      it { asset.description_or_file_name.must_equal 'image.png' }
      it 'should return description when present' do
        asset.description = 'Foo bar'
        asset.description_or_file_name.must_equal 'Foo bar'
      end
    end

    describe '#media' do
      let(:image) { FactoryBot.create :image_asset }
      let(:doc)   { FactoryBot.create :document_asset }

      describe 'with no args' do
        it { image.media.must_equal image.file }
        it { doc.media.must_equal doc.file }
      end
      describe 'with original style' do
        it { image.media(:original).must_equal image.file }
        it { doc.media(:original).must_equal doc.file }
      end
      describe 'with a non existing style' do
        it { image.media(:foo_bar).wont_equal image.file }
        it { proc { image.media(:foo_bar).width }.must_raise ArgumentError }
        it { doc.media(:foo_bar).must_equal doc.file }
      end
      describe 'with a geometry string' do
        it { image.media('48x56#').wont_equal image.file }
        it { image.media('48x56#').width.must_equal 48 }
        it { image.media('48x56#').height.must_equal 56 }
        it { image.media('48x56#').must_be_kind_of Dragonfly::Job }
        it { doc.media('48x56#').must_equal doc.file }
      end
    end

    describe '#preview_thumb' do
      let(:image) { FactoryBot.create :image_asset }
      let(:doc)   { FactoryBot.create :document_asset }
      it { image.preview_thumb.must_be_kind_of Dragonfly::Job }
      it { doc.preview_thumb.must_be_nil }
    end

    describe '#set_mime_type' do
      let(:asset) { FactoryBot.create :asset }
      it { asset.file_ext.must_equal 'png' }
      it { asset.mime_type.must_equal 'image/png' }
    end

  end
end
