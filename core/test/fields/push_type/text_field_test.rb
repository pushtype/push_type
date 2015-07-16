require "test_helper"

module PushType

  describe TextField do
    let(:field) { PushType::TextField.new :foo }
    let(:val)   { '15:00' }
    
    it { field.form_helper.must_equal :text_area }
  end

end