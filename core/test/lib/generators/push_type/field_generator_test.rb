require 'test_helper'
require "generators/push_type/field/field_generator"

module PushType
  class FieldGeneratorTest < Rails::Generators::TestCase
    tests FieldGenerator
    destination Rails.root.join('tmp/generators')

    before :all do
      prepare_destination
      run_generator ['rich_text']
    end

    it { assert_file 'app/fields/rich_text_field.rb', %r{class RichTextField < PushType::FieldType} }
  end
end
