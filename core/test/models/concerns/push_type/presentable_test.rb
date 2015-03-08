require "test_helper"

module PushType
  describe Presentable do

    describe 'class methods' do
      it { Page.presenter_class_name.must_equal 'PagePresenter' }
      it { Page.presenter_class.must_be_instance_of Class }
    end

    describe 'instance methods' do
      let(:page) { Page.new FactoryGirl.attributes_for(:node) }
      it { page.presenter_class.must_be_instance_of Class }
      it { page.present!.must_be_instance_of Page }
      it { page.present!.class.ancestors.must_include PushType::Presenter }
    end

  end
end