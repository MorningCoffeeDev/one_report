class TableItem < ActiveRecord::Base

  belongs_to :table_list, counter_cache: true

  validates :fields, format: { with: /\n\z/, message: "must end with return" }


  def to_pdf



  end

  def csv_fields
    begin
      CSV.parse_line(fields)
    rescue
      CSV.parse_line(fields, quote_char: '\'')
    end
  end

  def csv_array
    csv = []
    csv << CSV.parse_line(self.table_list.headers)
    csv << CSV.parse_line(self.fields)
    csv
  end

end