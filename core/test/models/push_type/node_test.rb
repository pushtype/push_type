require "test_helper"

module PushType
  describe Node do
    let(:node) { Node.new }

    it { node.wont_be :valid? }

    it 'should be valid with required attributes' do
      node.attributes = FactoryGirl.attributes_for :node
      node.must_be :valid?
    end

    describe '.published' do
      let(:nodes)     { PushType::Node.published }
      let(:new_node!) { FactoryGirl.create :published_node, attributes }
      before { @count = nodes.count }
      describe 'without published status' do
        it { proc { FactoryGirl.create :node }.wont_change 'nodes.count' }
      end
      describe 'with published_at dates in the future' do
        let(:attributes)  { { published_at: 1.day.from_now } }
        it { proc { new_node! }.wont_change 'nodes.count' }
      end
      describe 'with published_at dates in the past' do
        let(:attributes)  { { published_at: 2.days.ago } }
        it { proc { new_node! }.must_change 'nodes.count', 1 }
      end
      describe 'with published_to dates in the future' do
        let(:attributes)  { { published_at: 2.days.ago, published_to: 1.day.from_now } }
        it { proc { new_node! }.must_change 'nodes.count', 1 }
      end
      describe 'with published_to dates in the past' do
        let(:attributes)  { { published_at: 2.days.ago, published_to: 1.day.ago } }
        it { proc { new_node! }.wont_change 'nodes.count' }
      end
    end

    describe '#status' do
      let(:draft)     { FactoryGirl.create :node }
      let(:published) { FactoryGirl.create :published_node }
      let(:scheduled) { FactoryGirl.create :published_node, published_at: 1.day.from_now }
      let(:expired)   { FactoryGirl.create :published_node, published_at: 2.days.ago, published_to: 1.day.ago }
      it { draft.must_be :draft? }
      it { draft.wont_be :published? }
      it { draft.wont_be :scheduled? }
      it { draft.wont_be :expired? }
      it { published.wont_be :draft? }
      it { published.must_be :published? }
      it { published.wont_be :scheduled? }
      it { published.wont_be :expired? }
      it { scheduled.wont_be :draft? }
      it { scheduled.wont_be :published? }
      it { scheduled.must_be :scheduled? }
      it { scheduled.wont_be :expired? }
      it { expired.wont_be :draft? }
      it { expired.wont_be :published? }
      it { expired.wont_be :scheduled? }
      it { expired.must_be :expired? }
    end

    describe '#permalink' do
      before do
        %w(one two three).each { |slug| @node = FactoryGirl.create :node, slug: slug, parent: @node }
      end
      it { @node.permalink.must_equal 'one/two/three' }
    end

    describe '#default_values' do
      it { node.status.must_equal 'draft' }
    end

    describe '#set_published_at' do
      describe 'when publishing' do
        let(:node) { FactoryGirl.create :node }
        before { node.update_attribute :status, Node.statuses[:published] }
        it { node.published_at.wont_be_nil }
      end
      describe 'when publishing' do
        let(:node) { FactoryGirl.create :published_node }
        before { node.update_attribute :status, Node.statuses[:draft] }
        it { node.published_at.must_be_nil }
      end
    end

  end
end
