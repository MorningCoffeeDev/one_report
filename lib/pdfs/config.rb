require 'active_support/configurable'

module ReportPdf
  include ActiveSupport::Configurable

  configure do |config|
    config.default = ActiveSupport::OrderedOptions.new
    config.custom = ActiveSupport::OrderedOptions.new
    config.default.th = {
      align: :center,
      size: 12,
      font_style: :bold,
      height: 30,
      background_color: 'eeeeee'
    }
    config.default.td = {
      height: 28,
      align: :left,
      valign: :center,
      size: 8
    }

    config.custom.th = {}
    config.custom.td = {}
  end

end
