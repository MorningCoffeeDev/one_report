class ReportList < ActiveRecord::Base
  attachment :file

  belongs_to :reportable, polymorphic: true
  has_one :table_list
  has_many :table_lists
  delegate :one_report, to: :reportable

end