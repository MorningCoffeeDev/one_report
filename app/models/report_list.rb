class ReportList < ActiveRecord::Base
  attachment :file

  validates :file_filename, presence: true
  validates :file_content_type, presence: true
  validates :file_id, presence: true
end