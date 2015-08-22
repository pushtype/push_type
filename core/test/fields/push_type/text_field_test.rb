require 'test_helper'

module PushType
  class TextFieldTest < ActiveSupport::TestCase

    let(:field) { PushType::TextField.new :foo }
    let(:val)   { '15:00' }
    
    it { field.form_helper.must_equal :text_area }

  end
end