require 'test_helper'

module PushType
  class AdminHelperTest < ActionView::TestCase

    before { @view_flow = ActionView::OutputFlow.new }

    describe '#title' do
      let(:my_title) { 'My test title' }
      before { title my_title }
      it { content_for?(:title).must_equal true }
      it { content_for(:title).must_equal my_title }
    end

    describe '#ficon' do
      it 'should return an <i> element' do
        ficon(:foo).must_equal '<i class="fi-foo"></i>'
      end
      it 'should return any text' do
        ficon(:foo, 'My icon').must_equal '<i class="fi-foo"></i> My icon'
      end
    end

  end
end
