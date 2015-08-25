module ReportPdf
  include ReportConfig

  def remove_file_save
    self.remove_file = true
    self.save
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

  def config
    table_data = table_lists.includes(:table_items).map { |i| i.csv_array }
  end

end