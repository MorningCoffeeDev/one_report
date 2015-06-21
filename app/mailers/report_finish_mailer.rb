class ReportFinishMailer < ActionMailer::Base
  default from: "StudyTurf Notifications <notifications@studyturf.com.au>"

  def processing_complete(id)
    @report_list = ReportList.find(id)
    @message = @report_list.notice_body

    if Rails.env == 'production'
      @email = @report_list.email
    else
      @email = 'mingyuan0715@foxmail.com'
    end

    mail to: @email, subject: "Generation Complete #{@table_list.title}"
  end

end
