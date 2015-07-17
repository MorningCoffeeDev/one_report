require 'concerns/report_pdf'
class ReportList < ActiveRecord::Base
  include ReportPdf
  attr_accessible :reportable_id,
                  :reportable_type,
                  :reportable_name,
                  :notice_email,
                  :done

  attachment :file

  belongs_to :reportable, polymorphic: true
  has_one :table_list
  has_many :table_lists, dependent: :destroy
  has_many :table_items, through: :table_lists

  validates :reportable_id, presence: true
  validates :reportable_type, presence: true

  after_create :add_to_worker

  def run(save = false)
    unless self.done
      reportable.public_send(reportable_name)
      self.update_attributes(done: true)
      ReportFinishMailer.finish_notify(self.id).deliver if self.notice_email.present?
    end

    if save
      self.pdf_to_file
    end
  end

  def add_to_worker
    TableWorker.perform_async(self.id)
  end

  def table_items_count
    table_lists.sum(:table_items_count)
  end

  def published_value
    published ? 'published' : 'unpublished'
  end

end