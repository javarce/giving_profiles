class UserController < ApplicationController
  # Action for a logged in user's settings
  def settings
    @user = User.find(params[:id])
    @donations = Donation.where(user_id: @user.id).order(created_at: :desc)
    render file: "users/settings/index"
  end

  # Update donations privacy
  def update_donation_privacy
    donation_id = params[:donation]
    visibility = params[:visibility]

    donation = Donation.find(donation_id)
    donation.public = visibility
    donation.save()
    redirect_back(fallback_location: "user/#{params[:id]}/settings")
  end
end
