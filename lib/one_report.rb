require 'one_report/engine'
require 'one_report/base'

module OneReport
  module Model

    def generate_report(reportable_name)
      @report_list = ReportList.create(reportable_type: self.class.name,
                                       reportable_id: self.id,
                                       reportable_name: reportable_name)

      TableWorker.perform_async(@report_list.id)
    end

  end
end

def ENV.table; end
