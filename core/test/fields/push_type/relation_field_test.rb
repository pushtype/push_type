require 'test_helper'

module PushType
  class RelationFieldTest < ActiveSupport::TestCase

    class TestPage < PushType::Node
      field :page_id, :relation
      field :bar_ids, :relation, to: 'push_type/node', multiple: true
      field :baz_ids, :relation, to: :page, scope: -> { order(created_at: :desc).all }
      field :qux_ids, :relation, to: :page, scope: -> { all.hash_tree }
    end

    before do
      @pages  = 4.times.map { Page.create FactoryBot.attributes_for(:node) }
      @bars   = 2.times.map { TestPage.create FactoryBot.attributes_for(:node) }
    end

    let(:node)  { TestPage.create FactoryBot.attributes_for(:node, page_id: rel.id, bar_ids: @bars.map(&:id)) }
    let(:rel)   { @pages.first }
    let(:foo)   { node.fields[:page_id] }
    let(:bar)   { node.fields[:bar_ids] }
    let(:baz)   { node.fields[:baz_ids] }
    let(:qux)   { node.fields[:qux_ids] }

    it { foo.json_primitive.must_equal :string }
    it { foo.template.must_equal 'relation' }
    it { foo.wont_be :multiple? }
    it { foo.label.must_equal 'Page' }
    it { foo.html_options.keys.must_include :multiple }
    it { foo.json_value.must_equal rel.id }
    it { foo.value.must_equal rel.id }
    it { foo.choices.size.must_equal 4 }
    it { foo.choices.map { |c| c[:value] }.must_include rel.id }
    it { foo.relation_name.must_equal 'page' }
    it { foo.relation_class.must_equal Page }
    it { foo.relation_items.must_be_kind_of ActiveRecord::Relation }

    it { bar.json_primitive.must_equal :array }
    it { bar.must_be :multiple? }
    it { bar.label.must_equal 'Bars' }
    it { bar.relation_name.must_equal 'bars' }
    it { bar.relation_class.must_equal PushType::Node }
    it { bar.json_value.must_equal @bars.map(&:id) }
    it { bar.value.must_equal @bars.map(&:id) }
    it { bar.choices.size.must_equal 7 }
    it { bar.relation_items.must_be_kind_of ActiveRecord::Relation }

    it { baz.relation_class.must_equal Page }
    it { baz.choices.size.must_equal 4 }
    it { baz.relation_items.must_be_kind_of ActiveRecord::Relation }
    it { qux.choices.size.must_equal 4 }
    it { qux.relation_items.must_be_kind_of Hash }

    it { node.page_id.must_equal rel.id }
    it { node.page.must_equal rel }
    it { node.bar_ids.must_equal @bars.map(&:id) }
    it { node.bars.sort.must_equal @bars.sort }

    describe 'with missing relations' do
      before do
        @pages.first.destroy
        @bars.first.destroy
      end

      it { node.page.must_be_nil }
      it { node.bars.size.must_equal 1 }
    end

  end
end