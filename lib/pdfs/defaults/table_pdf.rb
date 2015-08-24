class TablePdf < ReportPdf

  def custom_table(data, options={}, &block)
    th_style = {
      align: :center,
      valign: :center,
      size: 12,
      font_style: :bold,
      height: 30,
      background_color: 'eeeeee'
    }
    td_style = {
      align: :left,
      valign: :center,
      size: 8
    }

    table(data, options) do
      row(0).style th_style
      row(1..-1).style td_style
    end
  end

end