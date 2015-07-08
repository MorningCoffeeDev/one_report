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


  def merged_pdf
    pdf = Prawn::Document.new
    report_lists.each_with_index do |list, index|
      pdf.start_new_page unless index == 0
      pdf.page.content << list.combine_pdf.page.content.stream.filtered_stream
    end

    pdf.render
  end

end
