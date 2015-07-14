require 'concerns/report_pdf'
class Combine < ActiveRecord::Base
  include ReportPdf
  attr_accessible :reportable_id,
                  :reportable_type,
                  :reportable_name

  attachment :file

  belongs_to :reportable, polymorphic: true
  has_many :combine_report_lists
  has_many :report_lists, through: :combine_report_lists
  has_many :table_lists, through: :report_lists

  validates :reportable_id, presence: true
  validates :reportable_type, presence: true

  after_create :add_to_worker

  def pdf_string
    pdf = CombinePDF.new
    report_lists.each do |list|
      pdf << CombinePDF.parse(list.pdf_string)
    end

    pdf.to_pdf
  end

  def add_to_worker
    CombineWorker.perform_in(500, self.id)
  end

end
