ActiveAdmin.register Job do
  scope :active, show_count: true
  scope :deactive, show_count: true


  member_action :activate, method: :put do
    job = Job.find(params[:id])
    job.status = 1
    job.save!
    redirect_to :back, notice: "Job is Activated"
  end

  action_item only: :show do
    link_to('Activate', activate_admin_job_path(job), method: :put) if job.status !=1
  end


  member_action :deactivate, method: :put do
    job = Job.find(params[:id])
    job.status = 0
    job.save!
    redirect_to :back, notice: "Job is DeActivated"
  end

  action_item only: :show do
    link_to('Deactivate', deactivate_admin_job_path(job), method: :put) if job.status !=0
  end



end
