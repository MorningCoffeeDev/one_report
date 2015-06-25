module Ausvels
  module Pdf
    class ResultRow < Row

      def process_table(data, options={}, &block)
        default_options = {
          cell_style: { height: 28 },
          column_widths: 225
        }

        default_options.merge!(options)

        if block_given?
          @pdf.table(data, default_options, &block)
        else
          @pdf.table(data, default_options) do
            column(0).style align: :left, valign: :center, size: 8
            column(1).style align: :left, valign: :center, size: 8
            column(2).style align: :center, valign: :center, size: 12
          end
        end

        @pdf.move_down 20
      end

    end
  end
end