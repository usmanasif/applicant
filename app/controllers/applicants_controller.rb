class ApplicantsController < ApplicationController

  def apply
    @job = Job.find params[:id]
    if request.post? && !params[:user].blank?
      @params = params[:user]
      applicant = Applicant.find_by_email_and_job_id(params[:user][:email], @job.id) if params[:user][:email]
      if applicant.blank?
        applicant = Applicant.new(params[:user])
        applicant.job = @job
        if applicant.save
          flash[:message] = SUCCESS_RESPONSE_MESSAGE
          UserMailer.send_applicant_confirmation(applicant).deliver
          redirect_to :back and return
        else
          @errors = applicant.errors.full_messages
        end
      else
        flash[:message] = ALREADY_APPLIED_RESPONSE_MESSAGE
        redirect_to :back and return
      end
    end
  end

end
