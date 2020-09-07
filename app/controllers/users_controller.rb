# frozen_string_literal: true

class UsersController < ApplicationController
  helper_method :cause_logos, :badge_logos
  before_action :user, only: %i[home show edit add_donation]
  before_action :ensure_current_user, :verify_access, only: %i[home edit]

  def show; end

  def edit; end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Successfully saved profile changes!"
      redirect_to @user
    else
      flash.now[:error] = @user.errors.full_messages.join(";  ")
      render action: "edit"
    end
  end

  def home
    redirect_to login_path unless user_signed_in?
    @network_donations = Donation.order(created_at: :desc).first(5)
  end

  # /users/:id/add_donation
  def add_donation
    organization = Organization.find_or_create_by(name: user_params[:organization_name])
    @donation = DonationService.create_donation(@user, organization, user_params[:amount])
    if @donation.save
      flash[:success] = "Successfully added donation!"
      # should redirect to user home page
    else
      flash[:error] = @donation.errors.full_messages.join(";  ")
      # should redirect to user home page with errors
    end
    redirect_to :home_user
  end

  private

  def user
    @user = User.find(params[:id])
  end

  def cause_logos
    {
      "animals" => "paw",
      "community_development" => "home",
      "education" => "graduation-cap",
      "environment" => "tree",
      "health" => "medkit",
      "human_rights" => "dove",
      "human_services" => "users",
      "international" => "globe",
      "religion" => "praying-hands",
      "unknown" => "question"
    }
  end

  def badge_logos
    cause_logos.merge({
                        "income" => "dollar-sign",
                        "highly_effective" => "check-circle",
                        "local" => "street-view"
                      })
  end

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :location,
                                 :email,
                                 :philosophy,
                                 :yearly_income,
                                 :organization_name,
                                 :amount,
                                 user_favorite_causes_attributes: %i[id description rank],
                                 user_favorite_organizations_attributes: %i[id description rank])
  end

  def ensure_current_user
    redirect_to root_path unless user_signed_in?
  end

  def verify_access
    render_forbidden unless user_signed_in? && @user == current_user
  end

  def render_forbidden
    render file: "public/403.html", status: 403, layout: false
  end
end
