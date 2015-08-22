require 'test_helper'

module PushType
  class TaxonomyFieldTest < ActiveSupport::TestCase

    let(:field) { PushType::TaxonomyField.new :foo, opts }

    before do
      root = Category.create FactoryGirl.attributes_for(:taxonomy)
      Category.create FactoryGirl.attributes_for(:taxonomy, parent: root)
      Category.create FactoryGirl.attributes_for(:taxonomy)
    end

    describe 'default' do
      let(:opts) { {} }
      it { field.json_key.must_equal :foo_id }
      it { field.field_options.must_equal({}) }
      it { field.relation_class.must_equal PushType::Taxonomy }
      it { field.relation_tree.size.must_equal 3 }
      it { field.relation_tree.map { |t| t[:depth] }.max.must_equal 1 }
    end

    describe 'with class option' do
      let(:opts) { { class: :category } }
      it { field.relation_class.must_equal Category }
    end

    describe 'with named field' do
      let(:field) { PushType::TaxonomyField.new :category }
      it { field.relation_class.must_equal Category }
    end
    
    describe 'initialized on node' do
      before do
        TestPage.instance_variable_set '@fields', ActiveSupport::OrderedHash.new
        TestPage.field :foo, :taxonomy
      end
      after { TestPage.instance_variable_set '@fields', ActiveSupport::OrderedHash.new }

      let(:node)  { TestPage.create attrs }
      let(:attrs) { FactoryGirl.attributes_for(:node) }

      describe 'without taxonomy' do
        it { node.foo_id.must_be_nil }
        it { node.foo.must_be_nil }
      end

      describe 'with taxonomy' do
        let(:attrs) { FactoryGirl.attributes_for(:node).merge(foo_id: taxonomy.id) }
        let(:taxonomy) { FactoryGirl.create :taxonomy }
        it { node.foo_id.must_equal taxonomy.id }
        it { node.foo.must_equal taxonomy }
      end
    end

  end
end