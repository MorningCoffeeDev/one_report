class ReportListsController < OneReport::BaseController
  before_filter :set_report_list, only: [:show, :destroy]

  def index
    @report_lists = ReportList.all
  end

  def show

    send_file @report_list.file.to_io,
              filename: @report_list.file_filename,
              type: @report_list.file_content_type
  end

  def destroy
    File.delete @export_file

    redirect_to export_files_url, notice: 'Export file was successfully destroyed.'
  end

  private
  def set_report_list
    @report_list = ReportList.find params[:id]
    #@report_list = params[:id] + '.' + params[:format]
  end

end
