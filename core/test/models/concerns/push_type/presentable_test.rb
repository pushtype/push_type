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
      let(:page) { TestPage.new FactoryBot.attributes_for(:node) }
      it { page.presenter_class.must_be_instance_of Class }
      it { page.location.presenter_class.must_be_instance_of Class }
      it { page.present!.class.ancestors.must_include PushType::Presenter }
      it { page.location.present!.class.ancestors.must_include PushType::Presenter }
    end

    it "autoloads the presenter" do
      begin
        ::PresentableNode = Class.new(PushType::Node)

        file = "#{Rails.root}/app/presenters/presentable_node_presenter.rb"
        File.write(file, <<-RUBY)
        class PresentableNodePresenter < PushType::Presenter
          def self.static?
            true
          end
        end
        RUBY

        PresentableNode.presenter_class_name.must_equal "PresentableNodePresenter"
        PresentableNode.presenter_class.static?.must_equal true
      ensure
        Object.send(:remove_const, :PresentableNode)
        Object.send(:remove_const, :PresentableNodePresenter) if defined?(::PresentableNodePresenter)
        FileUtils.rm_f(file)
      end
    end

  end
end