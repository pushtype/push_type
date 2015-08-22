require 'test_helper'
require "generators/push_type/node/node_generator"

module PushType
  class NodeGeneratorTest < Rails::Generators::TestCase
    tests NodeGenerator
    destination Rails.root.join('tmp/generators')

    before :all do
      prepare_destination
      run_generator ['home_page', 'foo', 'bar:text']
    end

    it { assert_file 'app/models/home_page.rb', %r{class HomePage < PushType::Node} }
    it { assert_file 'app/models/home_page.rb', %r{field :foo, :string} }
    it { assert_file 'app/models/home_page.rb', %r{field :bar, :text} }
    it { assert_file 'app/views/nodes/home_page.html.erb', %r{<h1><%= @node.title %></h1>} }
    it { assert_file 'app/views/nodes/home_page.html.erb', %r{<div>Foo:</div>} }
    it { assert_file 'app/views/nodes/home_page.html.erb', %r{<div><%= @node.foo %></div>} }
  end
end
