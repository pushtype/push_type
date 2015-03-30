require "test_helper"

module PushType
  describe ::PushType do

    describe '.version' do
      subject { PushType.version }
      it { subject.must_equal PushType::VERSION }
    end

    describe '.config' do
      subject { PushType.config }
      it { subject.root_nodes.wont_be_nil }
      it { subject.home_slug.wont_be_nil }
    end

    describe '.root_nodes' do
      subject { PushType.root_nodes }
      before  { PushType.config.root_nodes = root_nodes }
      after   { PushType.config.root_nodes = :all }
      describe 'defaults' do
        let(:root_nodes) { :all }
        it { subject.must_be_instance_of Array }
        it { subject.must_equal ['page', 'test_page'] }
      end
      describe 'specified single value' do
        let(:root_nodes) { :page }
        it { subject.must_equal ['page'] }
      end
      describe 'specified array with nonsense values' do
        let(:root_nodes) { [:page, :test_page, :foo, :bar] }
        it { subject.must_equal ['page', 'test_page'] }
      end
    end

    describe '.unexposed_nodes' do
      subject { PushType.unexposed_nodes }
      before  { PushType.config.unexposed_nodes = unexposed_nodes }
      after   { PushType.config.unexposed_nodes = [] }
      describe 'defaults' do
        let(:unexposed_nodes) { [] }
        it { subject.must_be_instance_of Array }
        it { subject.must_be_empty }
      end
      describe 'specified single value' do
        let(:unexposed_nodes) { :page }
        it { subject.must_equal ['page'] }
      end
      describe 'specified array with nonsense values' do
        let(:unexposed_nodes) { [:page, :test_page, :foo, :bar] }
        it { subject.must_equal ['page', 'test_page'] }
      end
    end

    describe '.node_types_from_list' do
      subject { PushType.node_types_from_list list }
      describe ':all' do
        let(:list) { :all }
        it { subject.must_equal ['page', 'test_page'] }
      end
      describe 'false' do
        let(:list) { false }
        it { subject.must_equal [] }
      end
      describe 'specified array with nonsense values' do
        let(:list) { [:page, :foo] }
        it { subject.must_equal ['page'] }
      end
    end

    describe '.taxonomy_classes' do
      subject { PushType.taxonomy_classes }
      describe 'defaults' do
        it { subject.must_be_instance_of Array }
        it { subject.must_equal [Category] }
      end
    end

    describe '.unexposed_taxonomies' do
      subject { PushType.unexposed_taxonomies }
      before  { PushType.config.unexposed_taxonomies = unexposed_taxonomies }
      after   { PushType.config.unexposed_taxonomies = [] }
      describe 'defaults' do
        let(:unexposed_taxonomies) { [] }
        it { subject.must_be_instance_of Array }
        it { subject.must_be_empty }
      end
      describe 'specified single value' do
        let(:unexposed_taxonomies) { :category }
        it { subject.must_equal ['category'] }
      end
      describe 'specified array with nonsense values' do
        let(:unexposed_taxonomies) { [:category, :foo, :bar] }
        it { subject.must_equal ['category'] }
      end
    end

    describe '.taxonomy_types_from_list' do
      subject { PushType.taxonomy_types_from_list list }
      describe ':all' do
        let(:list) { :all }
        it { subject.must_equal ['category'] }
      end
      describe 'false' do
        let(:list) { false }
        it { subject.must_equal [] }
      end
      describe 'specified array with nonsense values' do
        let(:list) { [:category, :foo] }
        it { subject.must_equal ['category'] }
      end
    end

  end
end
