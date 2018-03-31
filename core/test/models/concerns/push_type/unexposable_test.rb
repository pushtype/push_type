require 'test_helper'

module PushType
  class UnexposableTest < ActiveSupport::TestCase

    describe '.exposed' do
      let(:new_node!) { TestPage.create! FactoryBot.attributes_for(:node) }
      it 'should scope all exposed nodes' do
        PushType.stub :unexposed_nodes, [] do
          proc { new_node! }.must_change 'PushType::Node.exposed.count', 1
        end
      end
      it 'should omit any unexposed nodes' do
        PushType.stub :unexposed_nodes, ['test_page'] do
          proc { new_node! }.wont_change 'PushType::Node.exposed.count', 1 
        end
      end
    end

    describe 'exposed?' do
      it 'should be true when not unexposed' do
        PushType.stub :unexposed_nodes, [] do
          TestPage.must_be :exposed?
          TestPage.new.must_be :exposed?
        end
      end
      it 'should be false when unexposed' do
        PushType.stub :unexposed_nodes, ['test_page'] do
          TestPage.wont_be :exposed?
          TestPage.new.wont_be :exposed?
        end
      end
    end

    describe '.descendants' do
      it 'should include subject when not unexposed' do
        PushType.stub :unexposed_nodes, [] do
          PushType::Node.descendants.must_include TestPage
          PushType::Node.descendants(exposed: true).must_include TestPage
          PushType::Node.descendants(exposed: false).wont_include TestPage
        end
      end
      it 'should not include subject when not unexposed' do
        PushType.stub :unexposed_nodes, ['test_page'] do
          PushType::Node.descendants.must_include TestPage
          PushType::Node.descendants(exposed: true).wont_include TestPage
          PushType::Node.descendants(exposed: false).must_include TestPage
        end
      end
    end

  end
end