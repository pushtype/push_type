require 'test_helper'

module PushType
  class NodeTest < ActiveSupport::TestCase

    class TestPage < PushType::Node
      field :foo
      field :bar
      field :baz
    end

    let(:node) { Node.new }

    it { node.wont_be :valid? }

    it 'should be valid with required attributes' do
      node.attributes = FactoryBot.attributes_for :node
      node.must_be :valid?
    end

    describe '.find_by_base64_id' do
      let(:node)  { n = FactoryBot.build(:node); n.save(validate: false); n }
      let(:id)    { node.base64_id }
      it { PushType::Node.find_by_base64_id(id).must_equal node }
    end

    describe '#base64_id' do
      let(:node) { n = FactoryBot.build(:node); n.save(validate: false); n }
      it { Base64.urlsafe_decode64(node.base64_id).must_equal node.id }
    end

    describe '#permalink' do
      before do
        %w(one two three).each { |slug| @node = FactoryBot.build(:node, slug: slug, parent: @node); @node.save(validate: false); @node }
      end
      it { @node.permalink.must_equal 'one/two/three' }
    end

    describe '#orphan?' do
      let(:parent)  { FactoryBot.create :node }
      let(:child)   { n = FactoryBot.build(:node, parent: parent); n.save(validate: false); n }
      before { child && parent.trash! }
      it { parent.wont_be :orphan? }
      it { child.must_be :orphan? }
    end

    describe '#trash!' do
      let(:parent)  { FactoryBot.create :node }
      let(:child)   { n = FactoryBot.build(:node, parent: parent); n.save(validate: false); n }
      before { child && parent.trash! }
      it { parent.must_be :trashed? }
      it { child.reload.must_be :trashed? }
    end

  end
end
