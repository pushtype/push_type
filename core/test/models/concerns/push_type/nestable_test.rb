require "test_helper"

module PushType
  describe Nestable do

    # Reset to default
    before(:all) { PushType.config.root_node_types = :all }

    let(:page) { TestPage.new }
    let(:roots) { PushType.root_node_types }

    describe '.has_child_nodes' do
      describe 'defaults' do
        before do
          TestPage.instance_variable_set '@child_node_types', nil
          TestPage.instance_variable_set '@child_node_order', nil
        end
        it { TestPage.child_node_types.must_equal roots }
        it { page.child_node_types.must_equal roots }
        it { page.must_be :sortable? }
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

      describe 'without options' do
        before { TestPage.has_child_nodes :page, :test_page }
        it { TestPage.child_node_types.must_equal ['page', 'test_page'] }
        it { page.custom_child_order?.must_equal false }
        it { page.must_be :sortable? }
        it { page.children.order_values.must_include 'sort_order' }
      end

      describe 'with options' do
        before { TestPage.has_child_nodes :page, :test_page, order: 'name ASC' }
        it { TestPage.child_node_types.must_equal ['page', 'test_page'] }
        it { page.custom_child_order?.must_equal true }
        it { page.wont_be :sortable? }
        it { page.children.order_values.must_include 'name ASC' }
      end

      describe 'with template' do
        before { TestPage.has_child_nodes :page, :test_page, order: :blog }
        it { TestPage.child_node_types.must_equal ['page', 'test_page'] }
        it { page.custom_child_order?.must_equal true }
        it { page.wont_be :sortable? }
        it { page.children.order_values.must_equal ['published_at DESC', 'created_at DESC'] }
      end

    end

  end
end