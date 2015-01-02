require "test_helper"

module PushType
  describe InvitationMethods do

    subject { PushType::UsersController.new }

    it { subject.methods.include?(:invite).must_equal true }

  end
end
