require "test_helper"

module PushType
  describe Customizable do

    let(:page) { TestPage.new }
    let(:fields) { page.fields }

    it { TestPage.fields.must_be_instance_of ActiveSupport::OrderedHash }
    it { fields.must_be_instance_of ActiveSupport::OrderedHash }

    describe '.field' do
      before :all do
        TestPage.instance_variable_set '@fields', ActiveSupport::OrderedHash.new
        TestPage.field :foo
        TestPage.field :bar, :text
        TestPage.field :baz, validates: { presence: true }
        TestPage.field :qux, :rich_text, validates: { presence: true }
      end

      it { fields[:foo].must_be_instance_of StringField }
      it { fields[:bar].must_be_instance_of TextField }
      it { fields[:baz].must_be_instance_of StringField }
      it { TestPage.validators_on(:baz).map(&:class).must_include ActiveRecord::Validations::PresenceValidator }
      it { fields[:qux].must_be_instance_of RichTextField }
      it { TestPage.validators_on(:qux).map(&:class).must_include ActiveRecord::Validations::PresenceValidator }
    end

  end
end