require 'pdfs/table_pdf'
class TableList < ActiveRecord::Base

  belongs_to :report_list
  has_many :table_items

  validates :headers, format: { with: /\n$/, message: "must end with return" }

  def to_pdf
    pdf = TablePdf.new
    pdf.table(csv_array)
    pdf
  end

  def to_row_pdf
    pdf = TablesPdf.new
    self.table_items.each do |item|
      pdf.table item.csv_array
      pdf.start_new_page
    end

    pdf
  end

  def csv_array
    csv = []
    csv << CSV.parse_line(self.headers)
    self.table_items.each do |item|
      begin
        csv << CSV.parse_line(item.fields)
      rescue
      end
    end
    csv
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