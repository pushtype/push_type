require 'test_helper'

module PushType
  class PublishableTest < ActiveSupport::TestCase

    let(:node) { Node.new }

    describe '.published' do
      let(:nodes)     { PushType::Node.published }
      let(:new_node!) { FactoryBot.create :published_node, attributes }
      describe 'without published status' do
        it { expect { FactoryBot.create :node }.wont_change 'nodes.count' }
      end
      describe 'with published_at dates in the future' do
        let(:attributes)  { { published_at: 1.day.from_now } }
        it { expect { new_node! }.wont_change 'nodes.count' }
      end
      describe 'with published_at dates in the past' do
        let(:attributes)  { { published_at: 2.days.ago } }
        it { expect { new_node! }.must_change 'nodes.count', 1 }
      end
      describe 'with published_to dates in the future' do
        let(:attributes)  { { published_at: 2.days.ago, published_to: 1.day.from_now } }
        it { expect { new_node! }.must_change 'nodes.count', 1 }
      end
      describe 'with published_to dates in the past' do
        let(:attributes)  { { published_at: 2.days.ago, published_to: 1.day.ago } }
        it { expect { new_node! }.wont_change 'nodes.count' }
      end
    end

    describe '#set_default_status' do
      it { node.status.must_equal 'draft' }
    end

    describe '#status' do
      let(:draft)     { FactoryBot.create :node }
      let(:published) { FactoryBot.create :published_node }
      let(:scheduled) { FactoryBot.create :published_node, published_at: 1.day.from_now }
      let(:expired)   { FactoryBot.create :published_node, published_at: 2.days.ago, published_to: 1.day.ago }
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

    describe '#set_published_at' do
      describe 'when publishing' do
        let(:node) { FactoryBot.create :node }
        before { node.update_attribute :status, Node.statuses[:published] }
        it { node.published_at.wont_be_nil }
      end
      describe 'when publishing' do
        let(:node) { FactoryBot.create :published_node }
        before { node.update_attribute :status, Node.statuses[:draft] }
        it { node.published_at.must_be_nil }
      end
    end

  end
end