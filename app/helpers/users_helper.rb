# frozen_string_literal: true

module UsersHelper
  def user_page?
    user_signed_in? && current_user == @user
  end

  # TODO: this should be reworked
  def user_profile_page?
    controller_name == "users" && action_name == "show"
  end
end
