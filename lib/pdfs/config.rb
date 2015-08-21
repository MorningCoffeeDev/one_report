require 'active_support/configurable'

module ReportPdf
  include ActiveSupport::Configurable

  configure do |config|
    config.default = ActiveSupport::OrderedOptions.new
    config.custom = ActiveSupport::OrderedOptions.new
    config.default.th = {
      align: :center,
      valign: :center,
      size: 12,
      font_style: :bold,
      height: 30,
      background_color: 'eeeeee'
    }
    config.default.td = {
      align: :left,
      valign: :center,
      size: 8
    }
    config.default.document = {
      page_size: 'A4',
      margin: 75
    }

    config.custom.th = {}
    config.custom.td = {}
    config.custom.document ={}
  end

end
