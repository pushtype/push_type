require "test_helper"

module PushType
  describe ::PushType do

    describe '.config' do
      subject { PushType.config }
      it { subject.must_be_instance_of Rails::Engine::Configuration }
      it { subject.root_node_types.wont_be_nil }
      it { subject.home_node.wont_be_nil }
    end

    describe '.root_node_types' do
      subject { PushType.root_node_types }
      describe 'defaults' do
        before { PushType.config.root_node_types = :all }
        it { subject.must_be_instance_of Array }
        it { subject.must_equal ['page', 'test_page'] }
      end
      describe 'specified single value' do
        before { PushType.config.root_node_types = :page }
        it { subject.must_equal ['page'] }
      end
      describe 'specified array with nonsense values' do
        before { PushType.config.root_node_types = [:page, :test_page, :foo, :bar] }
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

  end
end
