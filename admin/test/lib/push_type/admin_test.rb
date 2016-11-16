require 'test_helper'

module PushType
  class AdminTest < ActiveSupport::TestCase

    it 'should have registered the admin engine' do
      PushType.rails_engines.keys.must_include :push_type_admin
    end

  end
end
