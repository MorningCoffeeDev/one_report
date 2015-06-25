class TablesPdf < Prawn::Document


  def initialize
    default = {
      page_size: 'A4'
    }
    super(default)
  end


  def table(data, options={}, &block)
    default_options = {

    }
    default_options.merge!(options)
    super(data, options, &block)
  end



end

