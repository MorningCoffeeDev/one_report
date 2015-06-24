class TableListsController < OneReport::BaseController
  before_filter :set_report_list
  before_filter :set_table_list, only: [:show]

  def index
    @table_lists = @report_list.table_lists
  end

  def show

    respond_to do |format|
      format.csv { send_data @table_list.csv_string, filename: @table_list.csv_file_name, type: 'application/csv' }
      format.pdf { send_data @table_list.to_pdf.render, filename: @table_list.pdf_file_name, type: 'application/pdf' }
    end
  end


  private
  def set_table_list
    @table_list = @report_list.table_lists.find(params[:id])
  end

  def set_report_list
    @report_list = ReportList.find params[:report_list_id]
  end


end
