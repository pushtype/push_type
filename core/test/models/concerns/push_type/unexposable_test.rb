require "test_helper"

module PushType
  class UnexposableTest < ActiveSupport::TestCase

    describe '.exposed' do
      let(:new_node!) { TestPage.create! FactoryGirl.attributes_for(:node) }
      it 'it should scope all exposed nodes' do
        PushType.stub :unexposed_nodes, [] do
          proc { new_node! }.must_change 'PushType::Node.exposed.count', 1
        end
      end
      it 'it should omit any unexposed nodes' do
        PushType.stub :unexposed_nodes, ['TestPage'] do
          proc { new_node! }.wont_change 'PushType::Node.exposed.count', 1 
        end
      end
    end

    describe 'exposed?' do
      describe 'when exposed' do
        it { TestPage.must_be :exposed? }
        it { TestPage.new.must_be :exposed? }
      end
      describe 'when unexposed' do
        before { TestPage.unexpose! }
        it { TestPage.wont_be :exposed? }
        it { TestPage.new.wont_be :exposed? }
      end
    end

  end
end