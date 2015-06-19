class TableListsController < OneReport::BaseController
  before_filter :set_table_list, only: [:show, :edit, :update, :destroy]

  def index
    @table_lists = TableList.all
  end

  def show


    respond_to do |format|
      format.csv { send_data @table_list.csv_string, filename: @table_list.csv_file_name, type: 'application/csv' }
      format.pdf { send_data @table_list.to_pdf.render, filename: @table_list.pdf_file_name, type: 'application/pdf' }
    end
  end

  def new
    @table_list = TableList.new
  end

  def edit
  end

  def create
    @table_list = TableList.new(table_list_params)

    if @table_list.save
      redirect_to @table_list, notice: 'Table list was successfully created.'
    else
      render :new
    end
  end

  def update
    if @table_list.update(table_list_params)
      redirect_to @table_list, notice: 'Table list was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @table_list.destroy
    redirect_to table_lists_url, notice: 'Table list was successfully destroyed.'
  end

  private
  def set_table_list
    @table_list = TableList.find(params[:id])
  end


end
