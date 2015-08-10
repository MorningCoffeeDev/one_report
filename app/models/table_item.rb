class TableItem < ActiveRecord::Base

  belongs_to :table_list, counter_cache: true

  #validates :fields, format: { with: /\n$/, message: "must end with return" }


  def to_pdf



  end

  def csv_fields
    CSV.parse_line(fields)
  end

  def csv_array
    csv = []
    csv << CSV.parse_line(self.table_list.headers)
    csv << CSV.parse_line(self.fields)
    csv
  end

end