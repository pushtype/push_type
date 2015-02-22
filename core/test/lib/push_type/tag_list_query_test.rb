require "test_helper"

module PushType
  describe TagListQuery do

    before do
      Page.fields = ActiveSupport::OrderedHash.new
      TestPage.fields = ActiveSupport::OrderedHash.new
      Page.field :tags, :tag_list
      TestPage.field :tags, :tag_list
      Page.create FactoryGirl.attributes_for(:node, tags: ['foo', 'bar'])
      Page.create FactoryGirl.attributes_for(:node, tags: ['baz'])
      TestPage.create FactoryGirl.attributes_for(:node, tags: ['foo', 'bang'])
    end

    after do
      Page.fields = ActiveSupport::OrderedHash.new
      TestPage.fields = ActiveSupport::OrderedHash.new
    end

    let(:query) { TagListQuery.new('tags', 'page') }

    describe '.all' do
      it 'should return the subjects tags' do
        query.all.must_equal ['bar', 'baz', 'foo']
      end
      it 'should return all node types tags' do
        query.all(type: :all).must_equal ['bang', 'bar', 'baz', 'foo']
      end
      it 'should return TestPage tags' do
        query.all(type: :test_page).must_equal ['bang', 'foo']
      end
    end

  end
end
