class AddFileInfoToReport < ActiveRecord::Migration
  def change
    add_column :report_lists, :file_filename, :string
    add_column :report_lists, :file_size, :integer
    add_column :report_lists, :file_content_type, :string
  end
end
