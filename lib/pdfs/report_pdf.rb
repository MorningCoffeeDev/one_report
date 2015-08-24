require 'prawn/measurement_extensions'
require 'prawn'

# a pdf object should response these methods
# * document
# * repeat_header
# * once_header
# * custom_table
# * once_footer
# * repeat_footer


class ReportPdf
  include Prawn::View

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

end


class Prawn::Document

  def empty?
    page.content.stream.length <= 2
  end

end
