module ReportPdf
  module Util

    def document(options = {})
      default_config = {
        page_size: 'A4',
        margin: 75
      }
      @document ||= Prawn::Document.new(default_config)
    end

    def make_row(data_array, default_options)
      result = []
      data_array.each do |data|
        result << make_cell(data, default_options)
      end
      result
    end

  end
end

class Prawn::Document

  def empty?
    page.content.stream.length <= 2
  end

end
