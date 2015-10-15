require 'test_helper'

module PushType
  class PrimitivesTest < ActiveSupport::TestCase

    describe 'Base' do
      let(:primitive) { PushType::Primitives::Base.new(val) }
      let(:val)       { 'abcde' }

      it { primitive.value.must_equal val }
      it { primitive.to_json.must_equal val }
    end

    describe 'ArrayType' do
      let(:primitive) { PushType::Primitives::ArrayType }
      let(:val)       { ['a', 'b', nil, '', 'c'] }

      it { primitive.to_json(val).must_equal ['a', 'b', 'c'] }
    end

    describe 'NumberType' do
      let(:primitive) { PushType::Primitives::NumberType }
      let(:val)       { '123.45' }

      it { primitive.to_json(val).must_equal 123.45 }
    end

    describe 'ObjectType' do
      let(:primitive) { PushType::Primitives::ObjectType }
      let(:val)       { { foo: 'bar', baz: ['a', 'b'] } }

      it { primitive.to_json(val).must_equal({ 'foo' => 'bar', 'baz' => ['a', 'b'] }) }
    end

    describe 'StringType' do
      let(:primitive) { PushType::Primitives::StringType }
      let(:val)       { 12345 }

      it { primitive.to_json(val).must_equal '12345' }
    end

  end
end