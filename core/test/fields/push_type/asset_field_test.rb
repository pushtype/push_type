require 'test_helper'

module PushType
  class AssetFieldTest < ActiveSupport::TestCase

    class TestPage < PushType::Node
      field :foo_id, :asset
    end

    let(:node)  { TestPage.create FactoryBot.attributes_for(:node, foo_id: asset.id) }
    let(:asset) { FactoryBot.create :asset }
    let(:field) { node.fields[:foo_id] }
    
    it { field.template.must_equal 'asset' }
    it { field.relation_class.must_equal PushType::Asset }
    it { field.json_value.must_equal asset.id }
    it { field.value.must_equal asset.id }

    it { node.foo_id.must_equal asset.id }
    it { node.foo.must_equal asset }

    describe 'with missing relations' do
      before do
        asset.destroy
      end

      it { node.foo.must_be_nil }
    end

  end
end