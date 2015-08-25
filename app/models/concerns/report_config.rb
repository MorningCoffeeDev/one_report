module ReportConfig

  def pdf_object
    if reportable.respond_to?(:pdf_object)
      reportable.pdf_object(reportable_name)
    else
      TablePdf.new
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
      reportable.ending_data
    else
      ''
    end
  end

end