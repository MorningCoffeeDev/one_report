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

      move_down 20
    end


    def pdf2_table(data, options={}, &block)
      default_options = {
        cell_style: { borders: [], padding: [5, 0, 0, 0] },
        column_widths: [275, 170]
      }
      default_options.merge!(options)

      if block_given?
        table(data, default_options, &block)
      else
        table(data, default_options) do
          table.rows(0).style valign: :top
          table.rows(1).style valign: :bottom
          table.column(0).style align: :left, padding: 0, font_style: :bold
          table.column(1).style align: :right, padding: 0
        end
      end
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

end
