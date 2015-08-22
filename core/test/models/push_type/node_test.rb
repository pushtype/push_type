require 'test_helper'

module PushType
  class NodeTest < ActiveSupport::TestCase
    let(:node) { Node.new }

    it { node.wont_be :valid? }

    it 'should be valid with required attributes' do
      node.attributes = FactoryGirl.attributes_for :node
      node.must_be :valid?
    end

    describe '#permalink' do
      before do
        %w(one two three).each { |slug| @node = FactoryGirl.create :node, slug: slug, parent: @node }
      end
      it { @node.permalink.must_equal 'one/two/three' }
    end

    describe '#orphan?' do
      let(:parent)  { FactoryGirl.create :node }
      let(:child)   { FactoryGirl.create :node, parent: parent }
      before { child && parent.trash! }
      it { parent.wont_be :orphan? }
      it { child.must_be :orphan? }
    end

    describe '#trash!' do
      let(:parent)  { FactoryGirl.create :node }
      let(:child)   { FactoryGirl.create :node, parent: parent }
      before { child && parent.trash! }
      it { parent.must_be :trashed? }
      it { parent.reload.must_be :trashed? }
    end

  end
end
