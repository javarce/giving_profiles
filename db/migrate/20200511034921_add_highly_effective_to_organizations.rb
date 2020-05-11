class AddHighlyEffectiveToOrganizations < ActiveRecord::Migration[5.2]
  def change
    add_column :organizations, :highly_effective, :boolean, default: false
  end
end
