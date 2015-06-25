class TablePdf < Prawn::Document


  def initialize
    default = {
      page_size: 'A4'
    }
    super(default)
  end



end