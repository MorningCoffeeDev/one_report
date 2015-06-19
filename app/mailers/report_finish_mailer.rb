class ReportFinishMailer < ActionMailer::Base


  default from: "StudyTurf Notifications <notifications@studyturf.com.au>"

  def processing_complete(id)
    @data_generator = TableList.find(id)
    @message = @data_generator.notices

    if Rails.env == 'production'
      @email = @data_generator.email
    else
      @email = 'adam.rice@morningcoffee.com.au'
    end

    mail to: @email, subject: "Generation Complete #{@data_generator.title}"
  end

end
