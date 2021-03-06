class ReportList < ActiveRecord::Base
  include ReportPdf

  attachment :file

  belongs_to :reportable, polymorphic: true
  has_many :table_lists, dependent: :destroy
  has_many :table_items, through: :table_lists

  validates :reportable_id, presence: true
  validates :reportable_type, presence: true
  validates :reportable_name, presence: true

  scope :published, -> { where(published: true) }

  after_commit :add_to_worker, on: :create

  def run(save = true, rerun: true)
    clear_old

    if !self.done || rerun
      reportable.public_send(reportable_name)
      self.update_attributes(done: true, published: true)
      ReportFinishMailer.finish_notify(self.id).deliver if self.notice_email.present?
    end

    if save
      self.pdf_to_file
    end
  end

  def clear_old
    self.done = false
    self.remove_file = true
    self.save
    table_lists.delete_all

    self.remove_file = nil
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