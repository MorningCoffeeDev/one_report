class TableItem < ActiveRecord::Base

  belongs_to :table_list, counter_cache: true

  validates :fields, format: { with: /\n$/,
                               message: "end with return" }

end