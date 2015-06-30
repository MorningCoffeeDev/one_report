class ReportCombine < ActiveRecord::Base
  belongs_to :combine, class_name: 'ReportList', foreign_key: :combine_id
  belongs_to :part, class_name: 'ReportList', foreign_key: :part_id


end
