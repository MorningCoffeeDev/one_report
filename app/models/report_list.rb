require 'concerns/report_pdf'
class ReportList < ActiveRecord::Base
  include ReportPdf
  attr_accessible :reportable_id,
                  :reportable_type,
                  :reportable_name,
                  :notice_email

  attachment :file

  belongs_to :reportable, polymorphic: true
  has_one :table_list
  has_many :table_lists
  has_many :table_items, through: :table_lists

  validates :reportable_id, presence: true
  validates :reportable_type, presence: true
  validates :reportable_name, presence: true

  after_create :add_to_worker

  def run
    unless self.done
      reportable.public_send(reportable_name)
    end
  end

  def add_to_worker
    TableWorker.perform_async(self.id)
  end



end