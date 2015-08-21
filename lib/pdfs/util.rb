require 'pdfs/config'

module ReportPdf
  module Util

    private
    def document
      config = style(:document)
      @document ||= Prawn::Document.new(config)
    end

    def style(name)
      default_style[name].merge custom_style[name]
    end

    def default_style
      ReportPdf.config.default
    end

    def custom_style
      ReportPdf.config.custom
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
