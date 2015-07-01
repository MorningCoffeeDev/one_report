module OneReport::Export

  def to_table
    @table_list = TableList.create(report_list_id: report_list_id,
                                   headers: header_values.to_csv)

    collection_result.each do |object|
      export_row(object)
    end
  end

  def export_row(object)
    results = []
    columns.each do |column|
      results << execute(object, fields[column], arguments[column])
    end

    row = CSV::Row.new(header_values, results)
    @table_list.table_items.create(fields: row.to_csv)
  end

  def execute(object, method, args)
    if method.is_a?(Symbol)
      result = object.send(method, *args)
    elsif method.is_a?(String)
      result = object.instance_eval(method)
    elsif method.blank?
      result = nil
    else
      raise 'wrong method type'
    end

    result.to_s
  end

end
