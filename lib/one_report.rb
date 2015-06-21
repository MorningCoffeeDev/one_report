require 'one_report/engine'
require 'one_report/base'

module OneReport
  module Model

    def generate_report
      @report_list = ReportList.create(reportable_type: self.class.name, reportable_id: self.id)
      worker = TableWorker.perform_async(@report_list.id)
      @report_list
    end

    def report
      @report ||= OneReport::Base.new
      @report.report_list_id ||= self.report_list.id
      @report
    end

  end
end

def ENV.table; end
