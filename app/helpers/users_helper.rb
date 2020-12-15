# frozen_string_literal: true

module UsersHelper
  def user_page?
    user_signed_in? && current_user == @user
  end

  # TODO: this should be reworked
  def user_profile_page?
    controller_name == "users" && action_name == "show"
  end

  def user_settings_page?
    controller_name == "user" && action_name == "settings"
  end

  def user_home_page?
    controller_name == "users" && action_name == "home"
  end
end
