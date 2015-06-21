class ReportListsController < OneReport::BaseController
  before_filter :set_report_list, only: [:show, :download, :destroy]

  def index
    @report_lists = ReportList.all
  end


  def show


    respond_to do |format|
      format.csv { send_data @table_list.csv_string, filename: @table_list.csv_file_name, type: 'application/csv' }
      format.pdf { send_data @table_list.to_pdf.render, filename: @table_list.pdf_file_name, type: 'application/pdf' }
    end
  end

  def download

    send_file @report_list.file.to_io,
              filename: @report_list.file_filename,
              type: @report_list.file_content_type
  end

  def destroy
    @report_list.destroy

    redirect_to export_files_url, notice: 'Export file was successfully destroyed.'
  end

  private
  def set_report_list
    @report_list = ReportList.find params[:id]
    #@report_list = params[:id] + '.' + params[:format]
  end

end
