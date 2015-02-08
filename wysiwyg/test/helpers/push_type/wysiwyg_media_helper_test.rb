require "test_helper"

module PushType
  describe WysiwygMediaHelper do

    describe '#wysiwyg_assets_hash' do
      let(:assets)  { PushType::Asset.page(1).per(2) }
      before  { 4.times { FactoryGirl.create :image_asset }  }
      subject { wysiwyg_assets_hash(assets) }
      it { subject.must_be_instance_of Hash }
      it { subject.key?(:assets).must_equal true }
      it { subject.key?(:meta).must_equal true }
      it { subject[:assets].must_be_instance_of Array }
      it { subject[:assets].size.must_equal 2 }
    end

    describe '#wysiwyg_assets_meta' do
      let(:assets)  { PushType::Asset.page(1).per(2) }
      before  { 4.times { FactoryGirl.create :image_asset }  }
      subject { wysiwyg_assets_meta(assets) }
      it { subject.must_be_instance_of Hash }
      it { subject.key?(:current_page).must_equal true }
      it { subject.key?(:total_pages).must_equal true }
      it { subject[:current_page].must_equal 1 }
      it { subject[:total_pages].must_equal 2 }
    end

    describe '#wysiwyg_asset_hash' do
      let(:asset) { FactoryGirl.create :image_asset }
      subject { wysiwyg_asset_hash(asset) }
      it { subject.must_be_instance_of Hash }
      it { subject.key?(:src).must_equal true }
      it { subject.key?(:info).must_equal true }
      it { subject[:info].key?(:id).must_equal true }
      it { subject[:info].key?(:src).must_equal true }
      it { subject[:info].key?(:kind).must_equal true }
      it { subject[:info].key?(:title).must_equal true }
    end

  end
end
