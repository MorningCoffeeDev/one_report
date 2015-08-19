class TableList < ActiveRecord::Base
  belongs_to :report_list
  has_many :table_items, dependent: :destroy

  validates :headers, format: { with: /\n\z/, message: "must end with return" }

  def brothers
    self.class.where(report_list_id: self.report_list_id)
  end


  def to_row_pdf
    self.table_items.each do |item|
      pdf.table item.csv_array
      pdf.start_new_page
    end

    pdf
  end

  def csv_headers
    CSV.parse_line(self.headers)
  end

  def csv_fields
    csv = []
    self.table_items.each do |item|
      begin
        csv << CSV.parse_line(item.fields)
      rescue
      end
    end
    csv
  end

  def csv_footers
    CSV.parse_line(self.footers) if self.footers.present?
  end

  def group_by_first_column
    csv_fields.group_by { |i| i[0] }
  end

  def pdf_fields
    self.table_items.each do |item|
      begin
        csv = CSV.parse_line(item.fields)
        table << pdf.process_result_row(csv)
      rescue
      end
    end
    table << CSV.parse_line(self.footers) if footers.present?
  end

  def csv_string
    csv = ''
    csv << headers
    self.table_items.each do |table_item|
      csv << table_item.fields
    end
    csv
  end

  def csv_file_name
    "#{self.id}.csv"
  end

  def pdf_file_name
    "#{self.id}.pdf"
  end

end