class CombinesController < OneReport::BaseController
  before_filter :set_combine, only: [:show, :download, :table_lists, :destroy]

  def show

    respond_to do |format|
      format.html
      format.pdf { send_data @combine.merged_pdf, filename: @combine.filename, type: 'application/pdf' }
    end
  end

  def download
    send_file @combine.file.to_io,
              filename: @combine.file_filename,
              type: @combine.file_content_type
  end

  def table_lists
    @table_lists = @combine.table_lists
  end

  def destroy
    @combine.destroy
    redirect_to combines_url, notice: 'Export file was successfully destroyed.'
  end

  private
  def set_combine
    @combine = Combine.find params[:id]
  end

end
