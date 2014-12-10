require "test_helper"

module PushType
  describe Nestable do

    let(:page) { TestPage.new }
    let(:roots) { PushType.root_node_types }

    describe '.has_child_nodes' do
      describe 'defaults' do
        before { TestPage.instance_variable_set '@child_node_types', nil }
        it { TestPage.child_node_types.must_equal roots }
        it { page.child_node_types.must_equal roots }
      end

      describe 'when none' do
        before { TestPage.has_child_nodes false }
        it { TestPage.child_node_types.must_equal [] }
        it { page.child_node_types.must_equal [] }
      end

      describe 'when all' do
        before { TestPage.has_child_nodes :all }
        it { TestPage.child_node_types.must_equal roots }
        it { page.child_node_types.must_equal roots }
      end

      describe 'when specific' do
        before { TestPage.has_child_nodes :page }
        it { TestPage.child_node_types.must_equal ['page'] }
        it { page.child_node_types.must_equal ['page'] }
      end

      describe 'when nonsense' do
        before { TestPage.has_child_nodes :foo, :bar }
        it { TestPage.child_node_types.must_equal [] }
        it { page.child_node_types.must_equal [] }
      end
    end

  end
end