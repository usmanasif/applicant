class UserMailer < ActionMailer::Base
  default from: FROM_EMAIL

  def send_applicant_confirmation(user)
    @name = user.full_name
    @email = user.email
    @job_title  = user.job.title
    @from = "Jobs #{COMPANY} <#{FROM_EMAIL}>"
    mail(:to => @email, :subject => "#{COMPANY} - Application Received")
  end

end
