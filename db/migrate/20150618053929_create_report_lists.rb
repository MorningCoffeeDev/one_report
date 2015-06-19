class CreateReportLists < ActiveRecord::Migration
  def change

    create_table :report_lists do |t|
      t.integer :reportable_id
      t.string :reportable_type
      t.string :file_id
      t.timestamps
    end

    create_table :table_lists do |t|
      t.integer :tabling_id
      t.string :tabling_type
      t.string :headers
      t.integer :table_items_count
      t.timestamps
    end

    create_table :table_items do |t|
      t.integer :table_list_id
      t.string :fields
      t.timestamps
    end

  end
end
