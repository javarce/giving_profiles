# frozen_string_literal: true

class Organization < ApplicationRecord
  include PgSearch::Model
  multisearchable against: %i[name cause location],
                  update_if: %i[name_changed? cause_changed? location_changed?]
  pg_search_scope :search_by_name_type_location, against: %i[name cause location]

  enum cause: {
    animals: "animals",
    community_development: "community_development",
    education: "education",
    environment: "environment",
    health: "health",
    human_rights: "human_rights",
    human_services: "human_services",
    international: "international",
    religion: "religion",
    unknown: "unknown"
  }

  has_many :donations, dependent: :destroy

  # TODO: move to a helper
  def profile_image
    avatar_url.present? ? avatar_url : "default_avatar"
  end
end
