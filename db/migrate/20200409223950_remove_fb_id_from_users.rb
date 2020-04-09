class RemoveFbIdFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :fb_id, :string
  end
end
