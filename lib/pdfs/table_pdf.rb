require 'pdfs/config'
require 'prawn/measurement_extensions'
class TablePdf
  include Prawn::View

  def document
    default = {
      page_size: 'A4',
      margin: 75
    }

    @document ||= Prawn::Document.new(default)
  end

  def custom_table(data, options={}, &block)
    default_options = {
      position: :center,
      width: 445,
      column_widths: { -1 => 150, -2 => 150 }
    }
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
      canvas do
        bounding_box [bounds.left+75, bounds.top-20], :width  => bounds.width do
          process_header(data)
        end
      end
    end

  end

  def repeat_footer
    number_pages "<page> / <total>", at: [bounds.right - 50, 0]
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

    move_down 50
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

class  Prawn::Document

  def empty?
    page.content.stream.length <= 2
  end

end