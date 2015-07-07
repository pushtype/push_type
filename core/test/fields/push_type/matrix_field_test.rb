require "test_helper"

module PushType

  describe MatrixField do
    let(:field) { PushType::MatrixField.new :foo, opts }
    let(:val)   { [{ key: 1, value: 2 }, { key: 3, value: 4 }] }

    describe 'default' do
      let(:opts) { {} }
      it { field.template.must_equal 'matrix' }
      it { field.multiple?.must_equal true }
      it { field.param.must_equal foo: [:key, :value] }
      it { field.mapping.must_equal key: :text_field, value: :text_field }
      it { field.struct.must_be_instance_of Class }
      it { field.to_json(val).must_be_instance_of Array }
      it { field.to_json(val)[0].must_be_instance_of Hash }
      it { field.from_json(val).must_be_instance_of Array }
      it { field.from_json(val)[0].must_be_kind_of Object }
      it { field.from_json(val)[0].key.must_equal 1 }
      it { field.from_json(val)[0].value.must_equal 2 }
    end

    describe 'with options' do
      let(:opts) { { mapping: [:this, :that, other: :number_field] } }
      let(:val)   { [{ this: 'a', that: 'b', other: '99' }] }

      it { field.mapping.must_equal this: :text_field, that: :text_field, other: :number_field }
      it { field.from_json(val)[0].this.must_equal 'a' }
      it { field.from_json(val)[0].that.must_equal 'b' }
      it { field.from_json(val)[0].other.must_equal '99' }
    end
  end

end