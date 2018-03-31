require 'test_helper'

module PushType
  class NumberFieldTest < ActiveSupport::TestCase

    class TestPage < PushType::Node
      field :foo, :number
      field :bar, :number
    end

    let(:node)  { TestPage.create FactoryBot.attributes_for(:node, foo: 1, bar: 1.234) }
    let(:foo)   { node.fields[:foo] }
    let(:bar)   { node.fields[:bar] }

    
    it { foo.json_primitive.must_equal :number }
    it { foo.form_helper.must_equal :number_field }
    it { foo.json_value.must_equal 1 }
    it { foo.value.must_equal 1 }
    it { bar.json_value.must_equal 1.234 }
    it { bar.value.must_equal 1.234 }

    it { node.foo.must_equal 1 }
    it { node.bar.must_equal 1.234 }

  end
end