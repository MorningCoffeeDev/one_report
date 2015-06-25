module OneReport
  module Pdf
    class HeaderRow < Row

      def process_table(data, options={}, &block)
        default_options = {
          cell_style: { height: 22 },
          column_widths: 225
        }

        default_options.merge!(options)

        if block_given?
          @pdf.table(data, default_options, &block)
        else
          @pdf.table(data, default_options) do
            cells.style align: :center, valign: :center, size: 8, font_style: :bold
            column(0).style borders: [:bottom]
            column(1).style borders: [:bottom, :right]
            column(highlight_index).style background_color: 'FFCC00'
          end
        end

        @pdf.move_down 20
      end

    end

  end
end