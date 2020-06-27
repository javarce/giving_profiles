class RenameOrgTypeToCauseInOganizations < ActiveRecord::Migration[5.2]
  def change
    rename_column :organizations, :org_type, :cause
  end
end
