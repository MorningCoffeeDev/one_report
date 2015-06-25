require 'pdfs/tables_pdf'
class ReportList < ActiveRecord::Base
  attr_accessible :reportable_id,
                  :reportable_type,
                  :reportable_name,
                  :notice_email

  attachment :file

  belongs_to :reportable, polymorphic: true
  has_one :table_list
  has_many :table_lists

  validates :reportable_id, presence: true
  validates :reportable_type, presence: true
  validates :reportable_name, presence: true

  def run
    unless self.done
      reportable.public_send(reportable_name)
    end
  end

  def each_row_pdf

  end

  def combine_pdf
    pdf = TablesPdf.new

    table_lists.includes(:table_items).each do |table|
      pdf.table table.csv_array
      pdf.start_new_page
    end

    pdf
  end

  def to_pdf
    pdf = TablePdf.new
    pdf.table(csv_array)
    pdf
  end

  def pdf_file_name
    "report_#{self.id}.pdf"
  end

end