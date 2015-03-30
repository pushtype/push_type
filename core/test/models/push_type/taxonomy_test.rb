require "test_helper"

module PushType
  describe Taxonomy do
    let(:taxonomy) { Taxonomy.new }

    it { taxonomy.wont_be :valid? }

    it 'should be valid with required attributes' do
      taxonomy.attributes = FactoryGirl.attributes_for :taxonomy
      taxonomy.must_be :valid?
    end

    describe '.base_slug' do
      it 'should by default be the class name' do
        taxonomy.base_slug.must_equal 'push_type/taxonomy'
      end
      describe 'setting the base_slug' do
        before  { Taxonomy.base_slug :foo_bar }
        after   { Taxonomy.base_slug nil }
        it { Taxonomy.base_slug.must_equal 'foo_bar' }
      end
    end

    describe '#permalink' do
      before do
        Taxonomy.base_slug :cat
        %w(one two three).each { |slug| @tax = FactoryGirl.create :taxonomy, slug: slug, parent: @tax }
      end
      after   { Taxonomy.base_slug nil }
      it { @tax.permalink.must_equal 'cat/one/two/three' }
    end

  end
end
