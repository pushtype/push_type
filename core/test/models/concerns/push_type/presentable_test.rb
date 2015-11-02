require 'test_helper'

module PushType
  class PresentableTest < ActiveSupport::TestCase

    class TestPage < PushType::Node
      field :location, :structure
    end

    describe 'class methods' do
      it { Page.presenter_class_name.must_equal 'PagePresenter' }
      it { Location.presenter_class_name.must_equal 'LocationPresenter' }
      it { Page.presenter_class.must_be_instance_of Class }
    end

    describe 'instance methods' do
      let(:page) { TestPage.new FactoryGirl.attributes_for(:node) }
      it { page.presenter_class.must_be_instance_of Class }
      it { page.location.presenter_class.must_be_instance_of Class }
      it { page.present!.class.ancestors.must_include PushType::Presenter }
      it { page.location.present!.class.ancestors.must_include PushType::Presenter }
    end

  end
end