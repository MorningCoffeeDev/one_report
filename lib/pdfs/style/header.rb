module OneReport::Pdf::Header
  attr_accessor :pdf

  def initialize(pdf)
    @pdf = pdf
  end

  def process_table(data, options={}, &block)
    default_options = {
      cell_style: { borders: [] },
      column_widths: [225,200]
    }

    default_options.merge!(options)

    if block_given?
      @pdf.table(data, default_options, &block)
    else
      @pdf.table(data, default_options) do
        column(0).style align: :left, padding: 0
        column(1).style align: :right, padding: 0
        row(0).style font_style: :bold, size: 14
        row(1).style size: 10
        row(2).style size: 10
      end
    end

    @pdf.move_down 20
  end

end