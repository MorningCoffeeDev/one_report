require 'pdfs/style'
require 'prawn/measurement_extensions'
class TablePdf < Prawn::Document
  include ReportPdf::Style

  def initialize
    default = {
      page_size: 'A4',
      margin: 2.6.cm
    }
    super(default)
  end

  def pdf_table(data, options={}, &block)
    default_options = { }
    default_options.merge!(options)
    th_style = style(:th)
    td_style = style(:td)

    if block_given?
      table(data, default_options, &block)
    else
      table(data, default_options) do
        row(0).style th_style
        row(1..-1).style td_style
      end
    end
  end

  private
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