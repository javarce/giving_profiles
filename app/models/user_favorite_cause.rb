# frozen_string_literal: true

class UserFavoriteCause < ApplicationRecord
  belongs_to :user

  validates :user_id, uniqueness: { scope: :cause }
end
