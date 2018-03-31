require 'test_helper'

module PushType
  class FieldTypeTest < ActiveSupport::TestCase

    let(:node)  { FactoryBot.create :node }
    let(:field) { PushType::FieldType.new :foo, node, opts }
    
    describe 'default' do
      let(:opts) { {} }
      it { field.name.must_equal :foo }
      it { field.model.must_equal node }
      it { field.kind.must_equal :field }
      it { field.primitive.must_equal PushType::Primitives::StringType }

      it { field.json_primitive.must_equal :string }
      it { field.template.must_equal 'default' }
      it { field.label.must_equal 'Foo' }
      it { field.form_helper.must_equal :text_field }
      it { field.html_options.must_equal({}) }
      it { field.field_options.must_equal({}) }
      it { field.multiple?.must_equal false  }
    end

    describe 'with options' do
      let(:opts)  { { json_primitive: :number, template: 'my_template', label: 'Bar', form_helper: :number_field, html_options: { some: 'opts' }, field_options: { more: 'opts'} } }
      it { field.json_primitive.must_equal :number }
      it { field.template.must_equal opts[:template] }
      it { field.label.must_equal opts[:label] }
      it { field.form_helper.must_equal opts[:form_helper] }
      it { field.html_options.must_equal opts[:html_options] }
      it { field.field_options.must_equal opts[:field_options] }
    end

  end
end
