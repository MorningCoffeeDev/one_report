module OneReport::Export

  def to_table
    @table_list = TableList.create(headers: header_values.to_csv)

    collection_result.map do |object|
      export_row(object)
    end
  end

  def export_row(object)
    results = []
    columns.each do |column|
      results << execute(object, fields[column])
    end

    row = CSV::Row.new(header_values, results)
    @table_list.table_items.create(fields: row.to_csv)
  end

  def execute(object, method)
    if method.is_a?(Symbol)
      result = object.send(method)
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
