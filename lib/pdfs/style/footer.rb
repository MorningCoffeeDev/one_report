class OneReport::Pdf::Footer
  attr_accessor :pdf

  def initialize(pdf)
    @pdf = pdf
  end

  def print(data)
    @pdf.move_down 5
  end

end