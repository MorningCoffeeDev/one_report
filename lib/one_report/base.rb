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
              :arguments,
              :collection_model,
              :collection_scope,
              :collection_args,
              :report_list_id

  def initialize(report_list_id)
    @report_list_id = report_list_id
    @collection_scope = nil
    @columns = []
    @headers = {}
    @fields = {}
    @arguments = {}
  end

  def collection_result
    collection_model.public_send(collection_scope, *collection_args)

  end

  def config
    raise 'should call in subclass'
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

  def self.to_table(*args)
    report_list_id = args.shift
    report = self.new(report_list_id)
    report.config(*args)
    report.to_table
  end

end
