class AddPublicToDonations < ActiveRecord::Migration[5.2]
  def change
    add_column :donations, :public, :boolean, default: true
  end
end
