require 'test_helper'
require "generators/push_type/presenter/presenter_generator"

module PushType
  class PresenterGeneratorTest < Rails::Generators::TestCase
    tests PresenterGenerator
    destination Rails.root.join('tmp/generators')

    before :all do
      prepare_destination
      run_generator ['page']
    end

    it { assert_file 'app/presenters/page_presenter.rb', %r{class PagePresenter < PushType::Presenter} }
  end
end
