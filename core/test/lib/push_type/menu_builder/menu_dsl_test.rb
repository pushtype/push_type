require 'test_helper'

module PushType
  module MenuBuilder
    class Dsl::MenuTest < ActiveSupport::TestCase

      let(:menu) { MenuBuilder::Menu.new }

      describe '.build' do
        before do
          MenuBuilder::Dsl::Menu.build(menu) do
            element :div
            html_options class: 'foo-bar'
            active_class 'foo-active'
          end
        end

        it { menu.element.must_equal :div }
        it { menu.html_options[:class].must_equal 'foo-bar' }
        it { menu.active_class.must_equal 'foo-active' }
      end

    end
  end
end
