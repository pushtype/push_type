require "test_helper"

module PushType
  describe Node do
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

  end
end
