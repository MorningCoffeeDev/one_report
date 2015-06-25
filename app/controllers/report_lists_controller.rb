class ReportListsController < OneReport::BaseController
  before_filter :set_report_list, only: [:show, :combine, :download, :destroy]
  after_filter :set_reportable, only: [:new, :create, :show, :download]

  def new
    @report_list = ReportList.new(reportable_type: params[:reportable_type],
                                  reportable_id: params[:reportable_id],
                                  reportable_name: params[:reportable_name])
  end

  def create
    @report_list = ReportList.new(params[:report_list])
    @report_list.save

    TableWorker.perform_async(@report_list.id)

    redirect_to report_list_table_lists_url(@report_list.id)
  end

  def show

  end

  def combine
    send_data @report_list.combine_pdf.render,
              filename: @report_list.pdf_file_name,
              type: 'application/pdf'
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

  def set_reportable
    @reportable = @report_list.reportable
  end

end
