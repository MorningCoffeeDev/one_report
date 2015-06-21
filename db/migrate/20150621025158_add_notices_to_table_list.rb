class AddNoticesToTableList < ActiveRecord::Migration
  def change
    add_column :report_lists, :table_lists_count, :integer, default: 0
    add_column :report_lists, :title, :string
    add_column :report_lists, :notice_email, :string
    add_column :report_lists, :notice_body, :string

    rename_column :table_lists, :tabling_id, :report_list_id
    remove_column :table_lists, :tabling_type
  end
end
