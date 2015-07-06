module ReportPdf

  def combine_pdf
    pdf = pdf_class.new

    pdf.repeat_header header_info

    table_lists.includes(:table_items).each_with_index do |value, index|
      pdf.start_new_page unless index == 0
      table = []
      table << value.csv_headers
      value.csv_fields.each do |row|
        table << row
      end
      pdf.custom_table table
    end

    pdf
  end

  def pdf_class
    if reportable.respond_to?(:pdf_class)
      reportable.pdf_class
    else
      TablePdf
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

    filename << '.' << extension unless filename.end_with?(extension)
  end

  def header_info
    if reportable.respond_to? :header_info
      reportable.header_info
    else
      [
        ['', ''],
        ['', '']
      ]
    end
  end

end