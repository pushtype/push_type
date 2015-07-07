require "test_helper"

module PushType

  describe NodeField do
    let(:field) { PushType::NodeField.new :foo, opts }

    before do
      home = TestPage.create FactoryGirl.attributes_for(:node, slug: 'home')
      TestPage.create FactoryGirl.attributes_for(:node, slug: 'child', parent: home)
      Page.create FactoryGirl.attributes_for(:node)
    end

    describe 'default' do
      let(:opts) { {} }
      it { field.json_key.must_equal :foo_id }
      it { field.field_options.must_equal({}) }
      it { field.relation_class.must_equal PushType::Node }
      it { field.relation_root.must_be_instance_of PushType::Node::ActiveRecord_Relation }
      it { field.relation_tree.size.must_equal 3 }
      it { field.relation_tree.map { |t| t[:depth] }.max.must_equal 1 }
    end

    describe 'with class option' do
      let(:opts) { { class: :page } }
      it { field.relation_class.must_equal Page }
      it { field.relation_root.must_be_instance_of Page::ActiveRecord_Relation }
      it { field.relation_tree.size.must_equal 1 }
      it { field.relation_tree.map { |t| t[:depth] }.max.must_equal 0 }
    end

    describe 'with named field' do
      let(:field) { PushType::NodeField.new :test_page }
      it { field.relation_class.must_equal TestPage }
      it { field.relation_root.must_be_instance_of TestPage::ActiveRecord_Relation }
      it { field.relation_tree.size.must_equal 2 }
      it { field.relation_tree.map { |t| t[:depth] }.max.must_equal 1 }
    end

    describe 'with root option' do
      let(:opts) { { root: 'home/child' } }
      it { field.relation_root.must_be_instance_of TestPage }
      it { field.relation_tree.size.must_equal 1 }
      it { field.relation_tree.map { |t| t[:depth] }.max.must_equal 0 }
    end
    
    describe 'initialized on node' do
      before do
        TestPage.instance_variable_set '@fields', ActiveSupport::OrderedHash.new
        TestPage.field :foo, :node
      end
      after { TestPage.instance_variable_set '@fields', ActiveSupport::OrderedHash.new }

      let(:node)  { TestPage.create attrs }
      let(:attrs) { FactoryGirl.attributes_for(:node) }

      describe 'without relation' do
        it { node.foo_id.must_be_nil }
        it { node.foo.must_be_nil }
      end

      describe 'with relation' do
        let(:attrs) { FactoryGirl.attributes_for(:node).merge(foo_id: rel.id) }
        let(:rel)   { FactoryGirl.create :node }
        it { node.foo_id.must_equal rel.id }
        it { node.foo.must_equal rel }
      end
    end
  end

end