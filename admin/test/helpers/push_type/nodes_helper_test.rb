require 'test_helper'

module PushType
  class NodesHelperTest < ActionView::TestCase

    describe '#nodes_array' do
      let(:nodes)  { 4.times.map { FactoryBot.create :node } }
      subject { nodes_array(nodes) }
      it { subject.must_be_instance_of Array }
      it { subject.first.must_be_instance_of Hash }
      it { subject.size.must_equal 4 }
    end

    describe '#node_hash' do
      let(:node) { FactoryBot.create :node }
      subject { node_hash(node) }
      it { subject.must_be_instance_of Hash }
      it { subject.key?(:type).must_equal true }
      it { subject.key?(:title).must_equal true }
      it { subject.key?(:slug).must_equal true }
      it { subject.key?(:status).must_equal true }
      it { subject.key?(:published_at).must_equal true }
      it { subject.key?(:published_to).must_equal true }
      it { subject.key?(:new_record?).must_equal true }
      it { subject.key?(:published?).must_equal true }
    end

  end
end
