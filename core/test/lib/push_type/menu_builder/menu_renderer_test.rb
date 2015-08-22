require 'test_helper'

module PushType
  module MenuBuilder
    class MenuRendererTest < ActionView::TestCase

      let(:menu)      { MenuBuilder::Menu.new }
      let(:item)      { MenuBuilder::MenuItem.new :foo }
      let(:renderer)  { MenuBuilder::MenuRenderer.new self }

      describe '#render_menu' do
        subject { renderer.render_menu menu }
        it { subject.must_be_kind_of String }
        it { subject.must_match %r{\A<ul>.*</ul>\z} }
      end

      describe '#render_item' do
        before { item.link = '/foobar' }
        subject { renderer.render_item item }
        it { subject.must_be_kind_of String }
        it { subject.must_match %r{\A<li><a href="/foobar">.*</a></li>\z} }
      end

    end
  end
end
