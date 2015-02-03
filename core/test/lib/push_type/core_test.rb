require "test_helper"

module PushType
  describe ::PushType do

    describe '.config' do
      subject { PushType.config }
      it { subject.must_be_instance_of Rails::Engine::Configuration }
      it { subject.root_nodes.wont_be_nil }
      it { subject.home_slug.wont_be_nil }
    end

    describe '.root_nodes' do
      subject { PushType.root_nodes }
      describe 'defaults' do
        before { PushType.config.root_nodes = :all }
        it { subject.must_be_instance_of Array }
        it { subject.must_equal ['page', 'test_page'] }
      end
      describe 'specified single value' do
        before { PushType.config.root_nodes = :page }
        it { subject.must_equal ['page'] }
      end
      describe 'specified array with nonsense values' do
        before { PushType.config.root_nodes = [:page, :test_page, :foo, :bar] }
        it { subject.must_equal ['page', 'test_page'] }
      end
    end

    describe '.unexposed_nodes' do
      subject { PushType.unexposed_nodes }
      describe 'defaults' do
        before { PushType.config.unexposed_nodes = [] }
        it { subject.must_be_instance_of Array }
        it { subject.must_be_empty }
      end
      describe 'specified single value' do
        before { PushType.config.unexposed_nodes = [:page] }
        it { subject.must_equal ['Page'] }
      end
      describe 'specified array with nonsense values' do
        before { PushType.config.unexposed_nodes = [:page, :test_page, :foo, :bar] }
        it { subject.must_equal ['Page', 'TestPage'] }
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

  end
end
