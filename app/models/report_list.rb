require 'pdfs/tables_pdf'
class ReportList < ActiveRecord::Base
  attr_writer :pdf
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

  def pdf
    @pdf ||= TablePdf.new
  end

  def run
    unless self.done
      reportable.one_report(reportable_name)
      TableWorker.perform_async(self.id)
    end
  end




  def temp_header_info
    [
      ['', reportable.student.person.full_name],
      ['Learning Conference Report', 'Semester 1, 2015']
    ]

  end

  def combine_pdf
    pdf = TablesPdf.new

    pdf.process_header temp_header_info

    table_lists.includes(:table_items).each_with_index do |value, index|
      table = []
      pdf.start_new_page unless index == 0
      table << pdf.process_header_row(value.csv_headers)
      value.csv_fields.each do |c|
        table << pdf.process_result_row(c)
      end
      pdf.table table
    end

    pdf
  end

  def pdf_file_name
    "report_#{self.id}.pdf"
  end

  def temp_file_name
    "#{self.id}-PersonalResponsibility #{reportable.student.code} - #{2015} Semester #{1}.pdf"
  end



end