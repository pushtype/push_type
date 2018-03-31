require 'test_helper'

module PushType
  class SelectFieldTest < ActiveSupport::TestCase

    class TestPage < PushType::Node
      field :foo, :select, choices: [['AAA', 'a'], ['BBB', 'b']]
      field :bars, :select, multiple: true, choices: -> { [['XXX', 'x'], ['YYY', 'y']] }
    end

    let(:node)  { TestPage.create FactoryBot.attributes_for(:node, foo: 'b', bars: ['x', 'y']) }
    let(:foo)   { node.fields[:foo] }
    let(:bars)  { node.fields[:bars] }

    it { foo.json_primitive.must_equal :string }
    it { foo.template.must_equal 'select' }
    it { foo.field_options.keys.must_include :include_blank }
    it { foo.html_options.keys.must_include :multiple }
    it { foo.wont_be :multiple? }
    it { foo.json_value.must_equal 'b' }
    it { foo.value.must_equal 'b' }
    it { foo.choices.must_equal [['AAA', 'a'], ['BBB', 'b']] }

    it { bars.json_primitive.must_equal :array }
    it { bars.must_be :multiple? }
    it { bars.json_value.must_equal ['x', 'y'] }
    it { bars.value.must_equal ['x', 'y'] }
    it { bars.choices.must_equal [['XXX', 'x'], ['YYY', 'y']] }

    it { node.foo.must_equal 'b' }
    it { node.bars.must_equal ['x', 'y'] }

  end
end