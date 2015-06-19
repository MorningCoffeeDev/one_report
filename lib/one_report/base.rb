require 'csv'
require 'one_report/config'
require 'one_report/import'
require 'one_report/export'

class OneReport::Base
  include OneReport::Import
  include OneReport::Export

  attr_reader :columns,
              :headers,
              :fields,
              :collection_model,
              :collection_scope
  attr_accessor :tabling_type, :tabling_id

  def initialize
    @collection_model = nil
    @collection_scope = []
    @columns = []
    @headers = {}
    @fields = {}
    @table_list = TableList.where(tabling_type: tabling_type, tabling_id: tabling_id).take
  end

  def collection_result
    collection_scope.inject(collection_model) do |model, scope|
      model.send(scope)
    end
  end

  def inflector
    @inflector = OneReport.config.inflector
  end

  def header_values
    @header_values = headers.values_at(*columns)
  end

  def field_values
    @field_values = fields.values_at(*columns)
  end

end
