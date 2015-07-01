class RenameCombinedToReportable < ActiveRecord::Migration
  def change
    rename_column :combines, :combined_id, :reportable_id
    rename_column :combines, :combined_type, :reportable_type
    rename_column :combines, :combined_name, :reportable_name
  end
end
