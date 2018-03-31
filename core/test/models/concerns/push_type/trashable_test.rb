require 'test_helper'

module PushType
  class TrashableTest < ActiveSupport::TestCase

    describe 'query scopes' do
      it { PushType::Node.respond_to?(:trashed).must_equal true }
      it { PushType::Node.respond_to?(:not_trash).must_equal true }
    end

    describe '#trashed?' do
      describe 'when not trash' do
        let(:page) { FactoryBot.create :node }
        it { page.trashed?.must_equal false }
        describe '#trash!' do
          before { page.trash! }
          it { page.trashed?.must_equal true }
        end
      end

      describe 'when trash' do
        let(:page) { FactoryBot.create :node, deleted_at: Time.zone.now }
        it { page.trashed?.must_equal true }
        describe '#restore!' do
          before { page.restore! }
          it { page.trashed?.must_equal false }
        end
      end
    end

  end
end