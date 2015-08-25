class Combine < ActiveRecord::Base
  include ReportPdf

  attachment :file

  belongs_to :reportable, polymorphic: true
  has_many :combine_report_lists, dependent: :delete_all
  has_many :report_lists, through: :combine_report_lists
  has_many :table_lists, through: :report_lists

  validates :reportable_id, presence: true
  validates :reportable_type, presence: true

  after_commit :add_to_worker, on: :create

  def run(save = true)
    remove_file_save
    self.pdf_to_file if save
  end

  def pdf_string
    pdf = CombinePDF.new
    report_lists.published.each do |list|
      pdf << CombinePDF.parse(list.pdf_string)
    end

    pdf.to_pdf
  end

  def add_to_worker
    CombineWorker.perform_in(500, self.id)
  end

end
