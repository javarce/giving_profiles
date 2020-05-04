class RemoveNickNameFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :nick_name, :string
  end
end
