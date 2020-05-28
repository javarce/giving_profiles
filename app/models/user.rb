# frozen_string_literal: true

class User < ApplicationRecord
  include PgSearch::Model
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
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
  validates :yearly_income, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

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

  def name
    "#{first_name} #{last_name}"
  end

  def cause_donations
    @cause_donations ||= Donation.joins(:organization)
                                 .where("user_id = ?", id)
                                 .select(:org_type, :amount)
                                 .group(:org_type)
                                 .sum(:amount)
  end

  def donation_total
    @donation_total ||= Donation.where("user_id = ?", id).sum(:amount).to_f
  end

  def highly_effective_donation_total
    @highly_effective_donation_total ||= Donation.joins(:organization)
                                                 .where("user_id = ? AND highly_effective = ?", id, true)
                                                 .sum(:amount)
  end

  def local_donation_total
    @local_donation_total ||= 0 # Placeholder
  end

  def income_percentage
    yearly_income.present? ? donation_total / yearly_income : 0
  end

  def highly_effective_percentage
    donation_total.positive? ? highly_effective_donation_total / donation_total : 0
  end

  def local_percentage
    donation_total.positive? ? local_donation_total / donation_total : 0
  end

  def badge_tiers(badges)
    thresholds = [0.1, 0.3, 0.5, 0.7, 0.9]
    badges.sort_by { |_b, p, _d| -p }
          .map { |b, p, d| [b, thresholds.find_index { |t| p < t } || thresholds.size, d] }
          .select { |_b, t, _d| t.positive? }
  end

  def badges
    @badges ||= badge_tiers([
      ["income", income_percentage, "of yearly income"],
      ["highly_effective", highly_effective_percentage, "to highly effective charities"],
      ["local", local_percentage, "to local charities"]
    ] + cause_donations.map do |c, a|
          [c, (a.to_f / cause_donations.values.sum), "to #{c.humanize capitalize: false} organizations"]
        end)
  end

  def donations_by_causes
    @donations_by_causes ||= cause_donations.sort_by { |_, a| -a }
                                            .map { |c, a| [c, (100 * a.to_f / cause_donations.values.sum).round] }
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
