require 'one_report/engine'
require 'one_report/base'

module OneReport
  module Model

    def generate_report_later(reportable_name)
      report_list = generate_report(reportable_name)
      TableWorker.perform_async(report_list.id)
    end

    def generate_report_now(reportable_name)
      generate_report(reportable_name)
      report_list.run
    end

    def generate_report(reportable_name)
      rl = ReportList.where(reportable_type: self.class.name,
                            reportable_id: self.id,
                            reportable_name: reportable_name).first

      if rl.blank?
        rl = ReportList.create(reportable_type: self.class.name,
                               reportable_id: self.id,
                               reportable_name: reportable_name)
      end
      rl
    end

  end
end

def ENV.table; end
