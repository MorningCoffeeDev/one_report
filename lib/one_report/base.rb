require 'csv'
require 'one_report/config'
require 'one_report/import'
require 'one_report/export'

class OneReport::Base
  include OneReport::Import
  include OneReport::Export

  attr_accessor :report_list_id,
                :collection,
                :columns,
                :headers,
                :footers,
                :fields,
                :arguments

  def initialize(report_list_id)
    @report_list_id = report_list_id
    @collection = nil
    @columns = []
    @headers = {}
    @footers = {}
    @fields = {}
    @arguments = {}
  end

  def collection_result
    collection.call
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

  def self.config(*args)
    report_list_id = args.shift
    report = self.new(report_list_id)
    report.config(*args)
  end

  def self.to_table(*args)
    config(*args).to_table
  end

end
