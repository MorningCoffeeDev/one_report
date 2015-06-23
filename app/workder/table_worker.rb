class TableWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(report_list_id, report_name)
    @report_list = ReportList.find(report_list_id)
    @report_list.run(report_name)
  end

end
