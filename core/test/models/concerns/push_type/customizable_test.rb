require "test_helper"

module PushType
  describe Customizable do

    let(:page) { TestPage.new }
    let(:fields) { page.fields }

    it { TestPage.fields.must_be_instance_of ActiveSupport::OrderedHash }
    it { fields.must_be_instance_of ActiveSupport::OrderedHash }

    describe '.field' do
      before do
        TestPage.instance_variable_set '@fields', ActiveSupport::OrderedHash.new
        TestPage.field :foo
        TestPage.field :bar, :text
        TestPage.field :baz, validates: { presence: true }
        TestPage.field :qux, :number, validates: { presence: true }
      end

      after do
        TestPage.instance_variable_set '@fields', ActiveSupport::OrderedHash.new
        TestPage.clear_validators!
      end

      it { fields[:foo].must_be_instance_of StringField }
      it { fields[:bar].must_be_instance_of TextField }
      it { fields[:baz].must_be_instance_of StringField }
      it { TestPage.validators_on(:baz).map(&:class).must_include ActiveRecord::Validations::PresenceValidator }
      it { fields[:qux].must_be_instance_of NumberField }
      it { TestPage.validators_on(:qux).map(&:class).must_include ActiveRecord::Validations::PresenceValidator }
    end

    describe '#field_params' do
      before do
        TestPage.instance_variable_set '@fields', ActiveSupport::OrderedHash.new
        TestPage.field :foo
        TestPage.field :bar, :text
        TestPage.field :baz, :tag_list
      end
      after { TestPage.instance_variable_set '@fields', ActiveSupport::OrderedHash.new }

      it { page.field_params.must_equal [:foo, :bar, { baz: [] }] }
    end

  end
end