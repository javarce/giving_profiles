class UserController < ApplicationController
  # Action for a logged in user's settings
  def settings
    @user = User.find(params[:id])
    @donations = Donation.where(user_id: @user.id).order(created_at: :desc)
    render file: "users/settings/index"
  end
end
