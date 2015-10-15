require 'test_helper'

module PushType
  class TaxonomyFieldTest < ActiveSupport::TestCase

    class TestPage < PushType::Node
      field :category_id, :taxonomy
      field :bar_ids, :taxonomy, multiple: true
    end

    before do
      @cats = 4.times.map { Category.create FactoryGirl.attributes_for(:taxonomy) }
      @bars = 2.times.map { FactoryGirl.create(:taxonomy) }
    end

    let(:node)  { TestPage.create FactoryGirl.attributes_for(:node, category_id: rel.id, bar_ids: @bars.map(&:id)) }
    let(:rel)   { @cats.first }
    let(:cat)   { node.fields[:category_id] }
    let(:bar)   { node.fields[:bar_ids] }

    it { cat.json_primitive.must_equal :string }
    it { cat.template.must_equal 'relation' }
    it { cat.wont_be :multiple? }
    it { cat.label.must_equal 'Category' }
    it { cat.html_options.keys.must_include :multiple }
    it { cat.json_value.must_equal rel.id }
    it { cat.value.must_equal rel.id }
    it { cat.choices.size.must_equal 4 }
    it { cat.choices.map { |c| c[:value] }.must_include rel.id }
    it { cat.relation_name.must_equal 'category' }
    it { cat.relation_class.must_equal Category }

    it { bar.json_primitive.must_equal :array }
    it { bar.must_be :multiple? }
    it { bar.label.must_equal 'Bars' }
    it { bar.json_value.must_equal @bars.map(&:id) }
    it { bar.value.must_equal @bars.map(&:id) }
    it { bar.choices.size.must_equal 6 }
    it { bar.relation_name.must_equal 'bars' }
    it { bar.relation_class.must_equal PushType::Taxonomy }

    it { node.category_id.must_equal rel.id }
    it { node.category.must_equal rel }
    it { node.bar_ids.must_equal @bars.map(&:id) }
    it { node.bars.sort.must_equal @bars.sort }

  end
end