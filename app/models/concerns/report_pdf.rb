require 'pdfs/tables_pdf'
module ReportPdf

  def combine_pdf
    pdf = TablesPdf.new

    pdf.process_header header_info

    table_lists.includes(:table_items).each_with_index do |value, index|
      table = []
      pdf.start_new_page unless index == 0
      table << pdf.process_header_row(value.csv_headers)
      value.csv_fields.each do |c|
        table << pdf.process_result_row(c)
      end
      pdf.table table
    end

    pdf
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