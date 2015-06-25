require 'pdfs/style'
class TablePdf < Prawn::Document
  include OneReport::Pdf::Style

  def initialize
    default = {
      page_size: 'A4'
    }
    super(default)
  end

end