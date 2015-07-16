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
        TestPage.create FactoryGirl.attributes_for(:node, tags: ['foo', 'bar'])
        TestPage.create FactoryGirl.attributes_for(:node, tags: ['baz', 'bar'])
        TestPage.create FactoryGirl.attributes_for(:node, tags: ['qux'])
      end
      after { TestPage.instance_variable_set '@fields', ActiveSupport::OrderedHash.new }
      it { TestPage.must_respond_to :all_tags }
      it { TestPage.all_tags.must_equal ['bar', 'baz', 'foo', 'qux'] }
    end
  end

end