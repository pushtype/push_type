require 'test_helper'

module PushType
  class AssetFieldTest < ActiveSupport::TestCase

    let(:field) { PushType::AssetField.new :foo }
    
    it { field.json_key.must_equal :foo_id }
    it { field.template.must_equal 'asset' }
    it { field.id_attr.must_equal 'foo-asset-modal' }
    it { field.relation_class.must_equal PushType::Asset }
    
    describe 'initialized on node' do
      before do
        TestPage.instance_variable_set '@fields', ActiveSupport::OrderedHash.new
        TestPage.field :foo, :asset
      end
      after { TestPage.instance_variable_set '@fields', ActiveSupport::OrderedHash.new }

      let(:node)  { TestPage.create attrs }
      let(:attrs) { FactoryGirl.attributes_for(:node) }

      describe 'without asset' do
        it { node.foo_id.must_be_nil }
        it { node.foo.must_be_nil }
      end

      describe 'with asset' do
        let(:attrs) { FactoryGirl.attributes_for(:node).merge(foo_id: asset.id) }
        let(:asset) { FactoryGirl.create :asset }
        it { node.foo_id.must_equal asset.id }
        it { node.foo.must_equal asset }
      end
    end

  end
end