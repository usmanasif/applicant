ActiveAdmin.register Applicant do
  scope :interviewed, show_count: true
  scope :not_reviewed, show_count: true
  scope :rejected, show_count: true

  member_action :download, method: :put, if: proc{ !current_admin_user.sponsor } do
    app = Applicant.find(params[:id])
    send_file(File.open Rails.root.to_s+'/public'+app.resume_url)
  end

  action_item only: :show do
    link_to('Download Resume', download_admin_applicant_path(applicant), method: :put)
  end

  member_action :interviewd, method: :put do
    app = Applicant.find(params[:id])
    app.interview!
    redirect_to :back, notice: "Applicant is set as interviewd"
  end

  action_item only: :show do
    link_to('Interviewed', interviewd_admin_applicant_path(applicant), method: :put)
  end

  member_action :rejected, method: :put do
    app = Applicant.find(params[:id])
    app.reject!
    redirect_to :back, notice: "Applicant is set as rejected"
  end

  action_item only: :show do
    link_to('Reject', rejected_admin_applicant_path(applicant), method: :put)
  end

  member_action :shortlisted, method: :put do
    app = Applicant.find(params[:id])
    app.shortlist!
    redirect_to :back, notice: "Applicant is set as shotlisted"
  end

  action_item only: :show do
    link_to('Shortlisted', shortlisted_admin_applicant_path(applicant), method: :put)
  end

  index do |applicant|
    column :id
    column :job
    column :full_name
    # column :email
    column :phone
    column :institute_name
    column :education
    column :cgpa
    column :experience
    column :languages
    # column :expected_salary
    column "Resume" do |a|
      link_to('Download', download_admin_applicant_path(a), method: :put)
    end
    default_actions
  end

end
