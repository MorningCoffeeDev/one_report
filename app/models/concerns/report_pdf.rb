module ReportPdf

  def pdf
    if reportable.respond_to?(:pdf_object)
      @pdf ||= reportable.pdf_object(reportable_name)
    else
      @pdf ||= TablePdf.new
    end
  end

  def remove_file_save
    self.remove_file = true
    self.save
    self.remove_file = nil
  end

  def pdf_data
    if file_id
      file.read
    else
      pdf_string
    end
  end

  def pdf_string
    pdf_result.render
  end

  def pdf_to_file
    self.file = StringIO.new(pdf_string)
    self.file_filename = filename
    self.file_content_type = 'application/pdf'
    self.save
  end

  def pdf_result
    pdf.table_data = table_lists.includes(:table_items).map { |i| i.csv_array }
    pdf.header_data = header_data
    pdf.ending_data = ending_data
    pdf.run
    pdf
  end


  def header_data
    if reportable.respond_to? :header_info
      reportable.header_info
    else
      [
        ['', ''],
        ['', '']
      ]
    end
  end

  def ending_data
    if reportable.respond_to? :ending_data
      reportable.try(:ending_data)
    else
      ''
    end
  end

  def filename(extension = 'pdf')
    filename = file_filename
    if filename
      filename
    elsif reportable.respond_to?(:filename)
      filename = reportable.filename
    else
      filename = "report_#{self.id}"
    end

    unless filename.end_with?(extension)
      filename << '.' << extension
    end

    filename
  end

end