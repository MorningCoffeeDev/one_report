require 'concerns/report_pdf'
class Combine < ActiveRecord::Base
  include ReportPdf
  attr_accessible :reportable_id,
                  :reportable_type,
                  :reportable_name,
                  :file_id,
                  :file

  attachment :file

  belongs_to :reportable, polymorphic: true
  has_many :combine_report_lists
  has_many :report_lists, through: :combine_report_lists
  has_many :table_lists, through: :report_lists

  validates :reportable_id, presence: true
  validates :reportable_type, presence: true

  after_create :add_to_worker

  def run(save = true)
    remove_file_save
    self.pdf_to_file if save.is_a?(TrueClass)
  end

  def stable_run
    remove_file_save

    pdf = CombinePDF.new
    report_lists.each do |list|
      begin
        pdf << CombinePDF.load(list.file.download.to_path)
      rescue
      end
    end

    temp = "#{Rails.root}/tmp/pdfs/#{self.id}_temp.pdf"
    pdf.save temp

    File.open(temp, 'rb') do|file|
       self.file = file
    end

    self.save
  end

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
