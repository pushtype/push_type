require "test_helper"

module PushType
  describe WysiwygField do
    let(:field) { PushType::WysiwygField.new :foo }
    it { field.form_helper.must_equal :text_area }
    it { field.html_options[:class].must_equal 'froala' }
  end
end