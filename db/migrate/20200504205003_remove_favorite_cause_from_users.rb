class RemoveFavoriteCauseFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :favorite_cause, :string
  end
end
