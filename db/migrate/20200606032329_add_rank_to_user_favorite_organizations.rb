class AddRankToUserFavoriteOrganizations < ActiveRecord::Migration[5.2]
  def change
    add_column :user_favorite_organizations, :rank, :integer
  end
end
