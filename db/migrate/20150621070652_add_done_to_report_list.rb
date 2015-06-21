class AddDoneToReportList < ActiveRecord::Migration
  def change
    add_column :report_lists, :done, :boolean, default: false
  end
end
