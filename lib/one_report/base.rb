require 'csv'
require 'active_support/concern'
require 'one_report/config'
require 'one_report/import'
require 'one_report/export'

class OneReport::Base
  extend ActiveSupport::Concern
  include OneReport::Import
  include OneReport::Export

  attr_reader :columns,
              :headers,
              :fields,
              :arguments,
              :collection_model,
              :collection_scope,
              :model,
              :report_list_id

  def initialize(report_list_id)
    @report_list_id = report_list_id
    @collection_scope = []
    @columns = []
    @headers = {}
    @fields = {}
    @arguments = {}
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

  module ClassMethods

    def to_table(*args)
      report_list_id = args.shift
      report = OneReport::Base.new(report_list_id)
      report.config(*args)
      report.to_table
    end

  end

end
