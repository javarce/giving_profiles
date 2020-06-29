class RemoveFavoriteCauseDescriptionFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :favorite_cause_description, :string
  end
end
