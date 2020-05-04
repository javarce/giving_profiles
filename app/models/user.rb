# frozen_string_literal: true

class User < ApplicationRecord
  include PgSearch
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  enum favorite_cause: Organization.org_types
  multisearchable against: %i[first_name last_name location],
                  update_if: %i[
                    first_name_changed?
                    last_name_changed?
                    location_changed?
                  ]

  pg_search_scope :search_by_name_email_location, against: %i[first_name last_name email location]

  has_many :user_favorite_organizations, dependent: :destroy
  has_many :favorite_organizations, through: :user_favorite_organizations, source: :organization
  has_many :donations, dependent: :destroy

  validates :email, uniqueness: true
  validates_presence_of :first_name, :last_name

  accepts_nested_attributes_for :user_favorite_organizations

  attr_accessor :organization_name
  attr_accessor :amount

  # rubocop:disable Metrics/AbcSize
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.password = Devise.friendly_token[0, 20]
      user.avatar_url = auth.info.image + "?type=large" # assuming the user model has a name
      # TODO: user.fb_url = _____
      user.uid = auth.uid
      user.provider = auth.provider
    end
  end
  # rubocop:enable Metrics/AbcSize

  # TODO: add more badge types
  def badges
    donations_by_causes.map { |cause, amount| cause }
  end

  def name
    "#{first_name} #{last_name}"
  end

  def donated_causes
    @donated_causes ||= Donation.joins(:organization).where("user_id = ?", id).select(:org_type, :amount)
  end

  def donations_by_causes
    @donations_by_causes ||= donated_causes.group(:org_type).sum(:amount).sort_by { |cause, amount| -amount }.map { |cause, amount| [cause, (100 * amount.to_f / donated_causes.sum(:amount)).round] }
  end

  # TODO: move to a helper
  def profile_image
    avatar_url.present? ? avatar_url : "default_avatar"
  end

  # Donations made by friends/network
  # TODO: scope to network donations
  def network_donations
    Donation.all
  end
end
