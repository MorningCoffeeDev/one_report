class CreateCombines < ActiveRecord::Migration
  def change
    create_table :combines do |t|
      t.integer  "combined_id"
      t.string   "combined_type"
      t.string   "combined_name"
      t.string   "file_id"
      t.string   "file_filename"
      t.integer  "file_size"
      t.string   "file_content_type"
      t.timestamps null: false
    end

    rename_table :report_combines, :combine_report_lists
    rename_column :combine_report_lists, :part_id, :report_list_id
  end
end
