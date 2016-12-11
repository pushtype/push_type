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

    describe 'BooleanType' do
      let(:primitive) { PushType::Primitives::BooleanType }

      it { primitive.to_json(nil).must_be_nil }
      it { primitive.to_json(false).must_equal false }
      it { primitive.to_json(0).must_equal false }
      it { primitive.to_json('').must_equal false }
      it { primitive.to_json('false').must_equal false }
      it { primitive.to_json(true).must_equal true }
      it { primitive.to_json(1).must_equal true }
      it { primitive.to_json('true').must_equal true }
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
      it { primitive.to_json({}).must_equal({}) }
    end

    describe 'StringType' do
      let(:primitive) { PushType::Primitives::StringType }
      let(:val)       { 12345 }

      it { primitive.to_json(val).must_equal '12345' }
    end

  end
end