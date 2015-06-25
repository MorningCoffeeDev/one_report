require 'pdfs/table_pdf'
class TableList < ActiveRecord::Base
  attr_writer :pdf, :table
  belongs_to :report_list
  has_many :table_items

  validates :headers, format: { with: /\n$/, message: "must end with return" }

  def pdf
    @pdf ||= TablePdf.new
  end

  def table
    @table ||= []
  end

  def to_pdf
    csv_headers
    csv_fields
    pdf.table(table)
    pdf
  end

  def to_row_pdf
    self.table_items.each do |item|
      pdf.table item.csv_array
      pdf.start_new_page
    end

    pdf
  end

  def csv_headers
    csv = CSV.parse_line(self.headers)
    table << pdf.process_header_row(csv)
  end

  def csv_fields
    self.table_items.each do |item|
      begin
        csv = CSV.parse_line(item.fields)
        table << pdf.process_result_row(csv)
      rescue
      end
    end
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