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
  has_many :table_items, through: :table_lists

  has_many :report_combines, foreign_key: :combine_id
  has_many :parts, through: :report_combines, source: :part

  validates :reportable_id, presence: true
  validates :reportable_type, presence: true
  validates :reportable_name, presence: true

  after_create :add_to_worker

  def pdf
    @pdf ||= TablePdf.new
  end

  def has_parts?
    parts.exists?
  end

  def part_table_lists
    TableList.where(report_list_id: self.part_ids)
  end

  def run
    unless self.done
      reportable.public_send(reportable_name)
    end
  end

  def add_to_worker
    TableWorker.perform_async(self.id)
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

  def file_filename
    filename = super
    if filename
      filename
    else
      "report_#{self.id}.pdf"
    end
  end

  def temp_header_info
    [
      ['', reportable.student.person.full_name],
      ['Learning Conference Report', 'Semester 1, 2015']
    ]
  end

  def temp_file_name
    "#{self.id}-PersonalResponsibility #{reportable.student.code} - #{2015} Semester #{1}.pdf"
  end

end