require "test_helper"

module PushType

  describe TagListField do
    let(:field) { PushType::TagListField.new :tags, opts }
    let(:val)   { ['foo', 'bar'] }

    describe 'default' do
      let(:opts) { {} }
      it { field.template.must_equal 'tag_list' }
      it { field.multiple?.must_equal true }
      it { field.param.must_equal tags: [] }
      it { field.html_options.keys.must_include :multiple }
      it { field.html_options.keys.must_include :placeholder }
      it { field.to_json(val + ['']).must_equal val }
    end

    describe 'initialized on node' do
      before do
        TestPage.instance_variable_set '@fields', ActiveSupport::OrderedHash.new
        TestPage.field :tags, :tag_list
        TestPage.create FactoryGirl.attributes_for(:node, tags: ['foo', 'bar', 'foo'])
        TestPage.create FactoryGirl.attributes_for(:node, tags: ['baz', 'bar'])
        TestPage.create FactoryGirl.attributes_for(:published_node, tags: ['qux'])
        @first = TestPage.create FactoryGirl.attributes_for(:node, tags: ['foo', 'bar', 'qux'])
        TestPage.create FactoryGirl.attributes_for(:published_node)
      end
      after { TestPage.instance_variable_set '@fields', ActiveSupport::OrderedHash.new }

      describe '#with_all_tags' do
        let(:tags) { ['foo', 'foo', 'bar', 'qux'] }
        it { TestPage.must_respond_to :with_all_tags }
        it { TestPage.with_all_tags(tags).must_be_instance_of TestPage::ActiveRecord_Relation }
        it { TestPage.with_all_tags(tags).count.must_equal 1 }
        it { TestPage.published.with_all_tags(tags).count.must_equal 0 }
        it { TestPage.published.with_all_tags('qux').count.must_equal 1 }
      end

      describe '#with_any_tags' do
        let(:tags) { ['foo', 'foo', 'bar', 'qux'] }
        it { TestPage.must_respond_to :with_any_tags }
        it { TestPage.with_any_tags(tags).must_be_instance_of Array }
        it { TestPage.with_any_tags(tags).count.must_equal 4 }
        it { TestPage.with_any_tags(tags).first.must_equal @first }
        it { TestPage.published.with_any_tags(tags).count.must_equal 1 }
      end

      describe '#all_tags' do
        it { TestPage.must_respond_to :all_tags }
        it { TestPage.all_tags.must_equal ['bar', 'baz', 'foo', 'qux'] }
        it { TestPage.published.all_tags.must_equal ['qux'] }
        it { TestPage.all_tags { TestPage.published }.must_equal ['qux'] }
      end
    end
  end

end