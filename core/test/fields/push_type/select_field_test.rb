require "test_helper"

module PushType

  describe SelectField do
    let(:field) { PushType::SelectField.new :foo, opts }
    let(:val)   { 'a' }

    describe 'default' do
      let(:opts) { {} }
      it { field.template.must_equal 'select' }
      it { field.multiple?.must_equal false }
      it { field.param.must_equal :foo }
      it { field.choices.must_equal [] }
      it { field.field_options.must_be_instance_of Hash }
      it { field.field_options.keys.must_include :include_blank }
      it { field.html_options.keys.must_include :multiple }
      it { field.to_json(val).must_equal val }
      it { field.from_json(val).must_equal val }
    end

    describe 'with options' do
      let(:opts) { { choices: ['a', 'b'], multiple: true } }
      let(:val)   { ['a', 'b'] }
      it { field.multiple?.must_equal true }
      it { field.choices.must_equal ['a', 'b'] }
      it { field.to_json(val).must_be_instance_of Array }
      it { field.to_json(val)[0].must_equal 'a' }
      it { field.from_json(val).must_be_instance_of Array }
      it { field.from_json(val)[0].must_equal 'a' }
    end

    describe 'with choices as proc' do
      let(:opts) { { choices: -> { [1,2,3] } } }
      it { field.choices.must_equal [1,2,3] }
    end

  end

end