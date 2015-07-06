require 'pdfs/config'
require 'prawn/measurement_extensions'
class TablePdf < Prawn::Document

  def initialize
    default = {
      page_size: 'A4',
      margin: 2.6.cm
    }
    super(default)
  end

  def custom_table(data, options={}, &block)
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


  def repeat_header(data)

    repeat :all do
      process_header(data)
    end

  end

  def process_header(data, options={}, &block)
    default_options = {
      cell_style: { borders: [] },
      column_widths: [225, 220]
    }

    default_options.merge!(options)

    if block_given?
      table(data, default_options, &block)
    else
      table(data, default_options) do
        row(0).style font_style: :bold, size: 14
        row(1..-1).style size: 10
        column(0).style align: :left, padding: 0
        column(1).style align: :right, padding: 0
        cells[2, 0].style size: 12 if cells[2, 0].present?
      end
    end

    move_down 20
  end


  def header_title(title)
    text title, size: 22, style: :bold
    horizontal_rule
  end

  def horizontal_rule
    move_down 10
    stroke_horizontal_rule
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