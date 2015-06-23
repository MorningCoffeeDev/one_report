class AddOptionNameToReportList < ActiveRecord::Migration
  def change
    rename_column :report_lists, :title, :reportable_name
  end
end
