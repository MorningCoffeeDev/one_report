class ReportList < ActiveRecord::Base
  attachment :file

  belongs_to :reportable, polymorphic: true
  has_one :table_list
  has_many :table_lists


  def run(report_name)
    @report ||= OneReport::Base.new
    @report.report_list_id = self.id
    @report.run(report_name)
  end

end