class AddFootersToTableLists < ActiveRecord::Migration
  def change
    add_column :table_lists, :footers, :string, limit: 4096
  end
end
