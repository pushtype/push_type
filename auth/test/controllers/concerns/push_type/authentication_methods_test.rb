require "test_helper"

module PushType
  describe AuthenticationMethods do

    subject { PushType::AdminController.new }
    let :before_filters do
      subject._process_action_callbacks.find_all { |x| x.kind == :before }.map(&:filter)
    end

    it { subject.methods.include?(:authenticate_user!).must_equal true }
    it { before_filters.include?(:authenticate_user!).must_equal true }

  end
end
