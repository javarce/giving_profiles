class AddFbUrlToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :fb_url, :string
  end
end
