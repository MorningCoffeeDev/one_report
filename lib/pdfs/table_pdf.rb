require 'prawn/measurement_extensions'
require 'prawn'
require 'pdfs/util'

class ReportPdf
  include Prawn::View
  include ReportPdf::Util

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