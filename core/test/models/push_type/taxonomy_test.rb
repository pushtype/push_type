require "test_helper"

module PushType
  describe Taxonomy do
    let(:taxonomy) { Taxonomy.new }

    it 'should by default be termed by the class name' do
      taxonomy.term.must_equal 'push_type/taxonomy'
    end

    describe 'setting the term' do
      before  { Taxonomy.termed :foo_bar }
      after   { Taxonomy.termed nil }
      it { Taxonomy.term.must_equal 'foo_bar' }
    end

    it { taxonomy.wont_be :valid? }

    it 'should be valid with required attributes' do
      taxonomy.attributes = FactoryGirl.attributes_for :taxonomy
      taxonomy.must_be :valid?
    end

    describe '#permalink' do
      before do
        Taxonomy.termed :cat
        %w(one two three).each { |slug| @tax = FactoryGirl.create :taxonomy, slug: slug, parent: @tax }
      end
      after   { Taxonomy.termed nil }
      it { @tax.permalink.must_equal 'cat/one/two/three' }
    end

  end
end
