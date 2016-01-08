require 'test_helper'

module PushType
  class CoreExtTest < ActiveSupport::TestCase

    describe 'to_bool' do
      # Strings
      it { ''.to_bool.must_equal false }
      it { '0'.to_bool.must_equal false }
      it { 'no'.to_bool.must_equal false }
      it { 'false'.to_bool.must_equal false }
      it { '1'.to_bool.must_equal true }
      it { 'anything else'.to_bool.must_equal true }

      # Fixnums
      it { 0.to_bool.must_equal false }
      it { 1.to_bool.must_equal true }
      it { 1234.to_bool.must_equal true }

      # Booleans
      it { false.to_i.must_equal 0 }
      it { false.to_bool.must_equal false }
      it { true.to_i.must_equal 1 }
      it { true.to_bool.must_equal true }

      # Nils
      it { nil.to_bool.must_equal false }
    end
    
  end
end