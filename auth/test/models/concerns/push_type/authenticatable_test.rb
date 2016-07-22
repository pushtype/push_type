require 'test_helper'

module PushType
  class AuthenticatableTest < ActiveSupport::TestCase

    let(:user) { PushType::User.new }

    describe 'database_athenticatable' do
      it { user.methods.include?(:password).must_equal true }
      it { user.methods.include?(:password_confirmation).must_equal true }
    end

    describe 'confirmable' do
      it { user.methods.include?(:confirm).must_equal true }
    end

    describe 'recoverable' do
      it { user.methods.include?(:reset_password).must_equal true }
    end

    describe 'rememberable' do
      it { user.methods.include?(:remember_me).must_equal true }
    end

    describe 'trackable' do
      it { user.methods.include?(:update_tracked_fields!).must_equal true }
    end

    describe 'validatable' do
      it { user.methods.include?(:password_required?).must_equal true }
      it { user.methods.include?(:email_required?).must_equal true }
    end

    describe '#password_required?' do
      subject { user.send(:password_required?) }
      describe 'with new user' do
        let(:user) { PushType::User.new }
        it { subject.must_equal false }
      end
      describe 'with existing user and clean password' do
        let(:user) { FactoryGirl.create :user }
        it { subject.must_equal false }
      end
      describe 'with existing user and dirty password' do
        let(:user) { FactoryGirl.create :user }
        before { user.password = 'newpassword' }
        it { subject.must_equal true }
      end
    end
    
  end
end