class Object
  infect_an_assertion :assert_difference,     :must_change, :block
  infect_an_assertion :assert_no_difference,  :wont_change, :block
end

class ActionController::TestResponse
  infect_an_assertion :assert_response,       :must_respond_with
  infect_an_assertion :assert_redirected_to,  :must_redirect_to
  infect_an_assertion :assert_template,       :must_render_template
  infect_an_assertion :assert_tag,            :must_have_tag
  infect_an_assertion :assert_no_tag,         :wont_have_tag
  infect_an_assertion :assert_select,         :must_select
  infect_an_assertion :assert_select_email,   :must_select_email
  infect_an_assertion :assert_select_encoded, :must_select_encoded
end

class ActionDispatch::TestResponse
  infect_an_assertion :assert_response,       :must_respond_with
  infect_an_assertion :assert_redirected_to,  :must_redirect_to
  infect_an_assertion :assert_template,       :must_render_template
  infect_an_assertion :assert_tag,            :must_have_tag
  infect_an_assertion :assert_no_tag,         :wont_have_tag
  infect_an_assertion :assert_select,         :must_select
  infect_an_assertion :assert_select_email,   :must_select_email
  infect_an_assertion :assert_select_encoded, :must_select_encoded
end