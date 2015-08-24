module ReportPdf

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

  def pdf_result
    pdf = pdf_object
    return pdf unless pdf.empty?

    default_options = {
      position: :center
    }

    pdf.repeat_header header_info
    table_lists.includes(:table_items).each_with_index do |value, index|
      pdf.start_new_page unless index == 0
      pdf.custom_table value.csv_array, default_options
    end
    pdf.once_footer(ending_data)
    pdf.repeat_footer
    pdf
  end

end