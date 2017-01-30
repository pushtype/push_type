require 'test_helper'

module PushType
  class CustomizableTest < ActiveSupport::TestCase

    class TestPage < PushType::Node
      field :foo
      field :bar, :text
      field :baz, validates: { presence: true }
      field :qux, :number, validates: { presence: true }
    end

    let(:page) { TestPage.new }
    let(:fields) { page.fields }

    it { TestPage.fields.must_be_instance_of Hash }
    it { fields.must_be_instance_of Hash }

    describe '.field' do
      it { fields[:foo].must_be_instance_of StringField }
      it { fields[:bar].must_be_instance_of TextField }
      it { fields[:baz].must_be_instance_of StringField }
      it { TestPage.validators_on(:baz).map(&:class).must_include ActiveRecord::Validations::PresenceValidator }
      it { fields[:qux].must_be_instance_of NumberField }
      it { TestPage.validators_on(:qux).map(&:class).must_include ActiveRecord::Validations::PresenceValidator }
    end

    describe '#attribute_for_inspect' do
      it { page.attribute_for_inspect(:field_store).must_equal "[:foo, :bar, :baz, :qux]" }
    end

    describe '#attribute_changed?' do
      it { page.foo_changed?.must_equal false }
      it { page.changes.key?(:foo).must_equal false }

      it 'returns true when attribute is changed' do
        page.foo = 'value'
        page.foo_changed?.must_equal true
      end

      it 'returns true when attribute is changed' do
        page.foo = 'value'
        page.changes.key?(:foo).must_equal true
      end
    end
  end
end