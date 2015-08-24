require 'prawn/measurement_extensions'
require 'prawn'
require 'pdfs/util'

class TablePdf
  include Prawn::View
  include ReportPdf::Util

  def custom_table(data, options={}, &block)
    th_style = style(:th)
    td_style = style(:td)

    table(data, options) do
      row(0).style th_style
      row(1..-1).style td_style
    end
  end

  def once_header(data = nil)
    text data
  end

  def repeat_header(data = nil)
    repeat :all do
      canvas do
        bounding_box [bounds.left+75, bounds.top-20], :width  => bounds.width do
          process_header(data)
        end
      end
    end
  end

  def once_footer(data = nil)
    move_down 10
    text data
  end

  def repeat_footer(data = nil, page = true)
    number_pages "<page> / <total>", at: [bounds.right - 50, 0] if page
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

end