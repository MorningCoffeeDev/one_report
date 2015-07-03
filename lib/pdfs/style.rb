require 'pdfs/config'

module ReportPdf
  module Style

    def repeat_header(data)

      repeat :all do
        process_header(data)
      end

    end

    def process_header(data, options={}, &block)
      default_options = {
        cell_style: { borders: [] },
        column_widths: [260, 260]
      }

      default_options.merge!(options)

      if block_given?
        table(data, default_options, &block)
      else
        table(data, default_options) do
          column(0).style align: :left, padding: 0
          column(1).style align: :right, padding: 0
          row(0).style font_style: :bold, size: 14
          row(1).style size: 10
          row(2).style size: 10
        end
      end

      move_down 20
    end

  end

end
