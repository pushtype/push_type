require 'test_helper'

module PushType
  class DateFieldTest < ActiveSupport::TestCase

    class TestPage < PushType::Node
      field :foo, :date
    end

    let(:node)  { TestPage.create FactoryBot.attributes_for(:node, foo: date.to_s) }
    let(:date)  { Date.today }
    let(:field) { node.fields[:foo] }
    
    it { field.template.must_equal 'date' }
    it { field.form_helper.must_equal :date_field }
    it { field.json_value.must_equal date.to_s }
    it { field.value.must_equal date }

    it { node.foo.must_equal date }

  end
end