class TableWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(table_list_id)
    @table_list = TableList.find(table_list_id)
    @table_list.one_report
  end

end
