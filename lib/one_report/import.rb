module OneReport::Import

  def collect(collection_model, *collection_scope)
    @collection_model = collection_model

    collection_scope.each do |scope|
      if collection_model.respond_to? scope
        @collection_scope << scope unless @collection_scope.include?(scope)
      else
        raise 'The scope did not defined'
      end
    end

    self
  end

  def column(name, field: nil, header: nil, argument: nil)
    unless name.is_a?(Symbol)
      raise 'must pass a symbol'
    end

    unless @columns.include?(name)
      @columns << name
    end

    if field.nil?
      @fields.merge!(name => name)
    elsif field.equal?(false)
      @fields.merge!(name => nil)
    elsif field.is_a?(Symbol)
      @fields.merge!(name => field)
    elsif field.respond_to?(:call)
      field = column_scope(name, field)
      @fields.merge!(name => field)
    else
      raise 'wrong field type'
    end

    if header.nil?
      header_default(name)
    elsif header.is_a?(String)
      @headers.merge!(name => header)
    else
      raise 'wrong header type'
    end

    if argument.nil?
      nil  # todo use next ?
    elsif argument.is_a?(Array)
      @arguments.merge!(name => argument)
    else
      raise 'wrong argument type'
    end

    self
  end

  def note(header: nil, footer: nil)
    @note_header = header
    @note_footer = footer
  end

  def header_default(name)
    h = {name => name.to_s.send(inflector)}
    @headers.merge! h
  end

  def column_scope(name, field)
    method_name = 'one_report_' + name.to_s
    scope(method_name, field)

    method_name.to_sym
  end

  def scope(name, body)
    unless body.respond_to?(:call)
      raise ArgumentError, 'The scope body needs to be callable.'
    end

    collection_model.send(:define_method, name) do |*args|
      instance_exec(*args, &body)
    end
  end

end
