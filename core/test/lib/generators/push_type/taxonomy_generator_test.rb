require "test_helper"
require "generators/push_type/taxonomy/taxonomy_generator"

module PushType
  describe TaxonomyGenerator do
    tests TaxonomyGenerator
    destination Rails.root.join('tmp/generators')

    before :all do
      prepare_destination
      run_generator ['category']
    end

    it { assert_file 'app/models/category.rb', %r{class Category < PushType::Taxonomy} }
  end
end
