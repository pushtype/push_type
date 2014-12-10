require "test_helper"
require "generators/push_type/node/node_generator"

module PushType
  describe NodeGenerator do
    tests NodeGenerator
    destination Rails.root.join('tmp/generators')

    before :all do
      prepare_destination
      run_generator ['home_page']
    end

    it { assert_file 'app/models/home_page.rb', %r{class HomePage < PushType::Node} }
    it { assert_file 'app/views/nodes/home_page.html.erb', %r{<h1><%= @node.title %></h1>} }
  end
end
