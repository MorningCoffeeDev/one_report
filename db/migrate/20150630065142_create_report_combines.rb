class CreateReportCombines < ActiveRecord::Migration
  def change
    create_table :report_combines do |t|
      t.integer :combine_id
      t.integer :part_id
      t.timestamps null: false
    end
  end
end
