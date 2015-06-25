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

  def combine_pdf
    pdf = TablesPdf.new

    table_lists.includes(:table_items).each_with_index do |table, index|
      pdf.start_new_page unless index == 0
      pdf.table table.csv_array
    end

    pdf
  end

  def pdf_file_name
    "report_#{self.id}.pdf"
  end

  def temp_file_name
    "PersonalResponsibility #{reportable.student.code} - #{reportable.ausvels_period.year} Semester #{reportable.ausvels_period.semester}.pdf"
  end



end