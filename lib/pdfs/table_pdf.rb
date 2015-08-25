require 'prawn/measurement_extensions'
require 'prawn'

# a pdf object should response these methods
# * document
# * repeat_header
# * once_header
# * custom_table
# * once_footer
# * repeat_footer


class TablePdf
  include Prawn::View
  attr_accessor :page, :beginning_data, :header_data, :footer_data, :ending_data

  def initialize
    @page = true
    @beginning_data = nil
    @header_data = nil
    @footer_data = nil
    @ending_data = nil
    @table_data = []
  end

  def document
    default_config = {
      page_size: 'A4',
      margin: 75
    }
    @document ||= Prawn::Document.new(default_config)
  end

  def body
    return self unless self.empty?

    once_header begin_data
    repeat_header header_data
    table_data.each_with_index do |value, index|
      start_new_page unless index == 0
      custom_table value
    end
    pdf.once_footer(ending_data)
    pdf.repeat_footer footer_data
    pdf
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

  def repeat_footer(data = nil)
    text data
    number_pages "<page> / <total>", at: [bounds.right - 50, 0] if page
  end

end


class Prawn::Document

  def empty?
    page.content.stream.length <= 2
  end

end
