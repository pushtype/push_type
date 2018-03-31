require 'test_helper'

module PushType
  class PresenterTest < ActiveSupport::TestCase

    let(:page) { Page.create FactoryBot.attributes_for(:node) }

    describe 'without view context' do
      let(:presenter) { PushType::Presenter.new page }
      it { presenter.must_be_instance_of Page }
      it { presenter.class.ancestors.must_include PushType::Presenter }
      it { presenter.model.must_equal page }
      it { presenter.title.must_equal page.title }
      it { proc { presenter.helpers }.must_raise RuntimeError }
    end

    describe 'with view context' do
      let(:view_context) { ApplicationController.new.view_context }
      let(:presenter) { PushType::Presenter.new page, view_context }
      it { presenter.helpers.must_respond_to :content_tag }
    end

  end
end
