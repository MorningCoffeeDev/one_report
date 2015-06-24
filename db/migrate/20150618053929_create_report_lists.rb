class CreateReportLists < ActiveRecord::Migration

  def change

    create_table "table_items", :force => true do |t|
      t.integer  "table_list_id"
      t.string   "fields", limit: 4096
      t.datetime "created_at",    :null => false
      t.datetime "updated_at",    :null => false
    end

    create_table "table_lists", :force => true do |t|
      t.integer  "report_list_id"
      t.string   "headers", limit: 4096
      t.integer  "table_items_count", default: 0
      t.datetime "created_at",        :null => false
      t.datetime "updated_at",        :null => false
    end

    create_table "report_lists", :force => true do |t|
      t.integer  "reportable_id"
      t.string   "reportable_type"
      t.string   "reportable_name"
      t.string   "file_id"
      t.string   "file_filename"
      t.integer  "file_size"
      t.string   "file_content_type"
      t.string   "notice_email"
      t.string   "notice_body"
      t.boolean  "done"
      t.integer  "table_lists_count", :default => 0
      t.datetime "created_at",                       :null => false
      t.datetime "updated_at",                       :null => false
    end

  end

end
