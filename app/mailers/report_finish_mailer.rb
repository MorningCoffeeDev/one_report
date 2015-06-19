class ReportFinishMailer < ActionMailer::Base
  default from: "StudyTurf Notifications <notifications@studyturf.com.au>"

  def processing_complete(id)
    @table_list = TableList.find(id)
    @message = @table_list.notices

    if Rails.env == 'production'
      @email = @table_list.email
    else
      @email = 'mingyuan0715@foxmail.com'
    end

    mail to: @email, subject: "Generation Complete #{@table_list.title}"
  end

end
