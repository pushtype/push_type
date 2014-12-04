module PushType
  module UsersHelper

    def last_logged_in(user)
      if user.respond_to?(:current_sign_in_at) && user.current_sign_in_at?
        "Logged in #{ time_ago_in_words user.current_sign_in_at } ago"
      else
        'Never logged in'
      end
    end

  end
end
