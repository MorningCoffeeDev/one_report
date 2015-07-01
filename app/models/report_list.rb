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
  has_many :table_items, through: :table_lists

  has_many :report_combines, foreign_key: :combine_id
  has_many :parts, through: :report_combines, source: :part

  validates :reportable_id, presence: true
  validates :reportable_type, presence: true
  validates :reportable_name, presence: true

  after_create :add_to_worker

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

    pdf.process_header header_info

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

  def filename(extension = 'pdf')
    filename = file_filename
    if filename
      filename
    elsif reportable.respond_to?(:filename)
      filename = reportable.filename
    else
      filename = "report_#{self.id}"
    end

    filename << '.' << extension unless filename.end_with?(extension)
  end

  def header_info
    if reportable.respond_to? :header_info
      reportable.header_info
    else
      [
        ['', ''],
        ['', '']
      ]
    end
  end

end