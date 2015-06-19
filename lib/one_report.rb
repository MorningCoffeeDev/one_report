require 'one_report/engine'
require 'one_report/base'

module OneReport
  module Model

    def generate_report
      @table_list = TableList.create(tabling_type: self.class.name, tabling_id: self.id)
      TableWorker.perform_async(@table_list.id)
    end

  end
end

def ENV.table; end
