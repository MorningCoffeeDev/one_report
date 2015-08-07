require 'concerns/report_pdf'
class ReportList < ActiveRecord::Base
  include ReportPdf

  attachment :file

  belongs_to :reportable, polymorphic: true
  has_one :table_list
  has_many :table_lists, dependent: :destroy
  has_many :table_items, through: :table_lists

  validates :reportable_id, presence: true
  validates :reportable_type, presence: true

  scope :published, -> { where(published: true) }

  after_commit :add_to_worker, on: :create

  def run(save = true, rerun: true)
    table_lists.delete_all
    remove_file_save

    if !self.done || rerun
      reportable.public_send(reportable_name)
      self.update_attributes(done: true, published: true)
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