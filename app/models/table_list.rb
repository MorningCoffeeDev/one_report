require 'pdfs/table_pdf'
class TableList < ActiveRecord::Base
  attr_writer :pdf, :table
  belongs_to :report_list
  has_many :table_items, dependent: :destroy

  validates :headers, format: { with: /\n\z/, message: "must end with return" }

  def pdf
    @pdf ||= TablePdf.new
  end

  def brothers
    self.class.where(report_list_id: self.report_list_id)
  end

  def table
    @table ||= []
  end

  def to_pdf
    table << pdf.process_header_row(csv_headers)
    pdf_fields
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

  def pdf_fields
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