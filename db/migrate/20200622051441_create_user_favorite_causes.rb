class CreateUserFavoriteCauses < ActiveRecord::Migration[5.2]
  def change
    create_table :user_favorite_causes do |t|
      t.bigint :user_id
      t.string :cause
      t.string :description
      t.integer :rank

      t.timestamps
    end
    add_index :user_favorite_causes, [:cause]
    add_index :user_favorite_causes, [:user_id, :cause], unique: true
    add_index :user_favorite_causes, [:user_id]
  end
end
