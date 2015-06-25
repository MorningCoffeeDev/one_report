require 'active_support/configurable'

module OneReport
  module Pdf
    module Style

      def repeat_header(data)

        repeat :all do
          move_down 20
          bounding_box [bounds.left, bounds.top], :width  => bounds.width do
            process_header(data)
            move_down 20
          end
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

      def process_header_row(data, options={})
        default_options = {
          height: 30,
          background_color: 'eeeeee',
          align: :center,
          valign: :center,
          size: 12,
          font_style: :bold
        }

        default_options.merge!(options)

        make_row(data, default_options)
      end

      def process_result_row(data, options={})
        default_options = {
          height: 28,
          align: :left,
          valign: :center,
          size: 8
        }

        default_options.merge!(options)

        make_row(data, default_options)
      end

      def make_row(data_array, default_options)
        result = []
        data_array.each do |data|
          result << make_cell(data, default_options)
        end
        result
      end

    end
  end
end
