require 'test_helper'
require "generators/push_type/structure/structure_generator"

module PushType
  class StructureGeneratorTest < Rails::Generators::TestCase
    tests StructureGenerator
    destination Rails.root.join('tmp/generators')

    before :all do
      prepare_destination
      run_generator ['location', 'foo', 'bar:text']
    end

    it { assert_file 'app/models/location.rb', %r{class Location < PushType::Structure} }
    it { assert_file 'app/models/location.rb', %r{field :foo, :string} }
    it { assert_file 'app/models/location.rb', %r{field :bar, :text} }
  end
end
