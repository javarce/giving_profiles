# frozen_string_literal: true

module UsersHelper
  def user_page?
    user_signed_in? && current_user == @user
  end

  # TODO: this should be reworked
  def user_profile_page?
    controller_name == "users" && action_name == "show"
  end

  def user_header_info_alignment
    user_profile_page? ? "align-self-end" : "align-self-center"
  end
end
