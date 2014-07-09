class Applicant < ActiveRecord::Base
  belongs_to :job

  attr_accessible :languages,:institute_name,:expected_salary,:status,:full_name,:job_id,:dob,:email,:phone,:experience,:experience_description,:education,:resume,:cgpa,:available_at,:cover_letter

  mount_uploader :resume, ResumeUploader

  validates :full_name, :presence => {:message => ' cannot be blank.'}
  validates :email, :presence => {:message => ' cannot be blank.'},:format => { :with => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/ }
  validates :resume, :presence => {:message => ' cannot be empty.'}
  validates :phone, :presence => {:message => ' cannot be blank.'}
  validates :dob, :presence => {:message => ' cannot be blank.'}
  validates :cgpa,:presence => {:message => ' cannot be blank.'}, :inclusion=> { :in=> 2..4.5,:message=>" has to be greater then 2 and less then 4.5" }
  validates :institute_name, :presence => {:message => ' cannot be blank.'}
  validates :education, :presence => {:message => ' cannot be blank.'}

  validate :resume_size_validation

  scope :not_reviewed, lambda {where("applicants.status = 'not_reviewed' ") }
  scope :interviewed, lambda {where("applicants.status = 'interviewed' ") }
  scope :shortlisted, lambda {where("applicants.status = 'shortlisted' ") }
  scope :rejected, lambda {where("applicants.status = 'rejected' ") }

  state_machine :status, initial: :not_reviewed do
    state :not_reviewed
    state :shortlisted
    state :interviewed
    state :rejected

    event :shortlist do
      transition all => :shortlisted
    end

    event :interview do
      transition all => :interviewed
    end

    event :reject do
      transition all => :rejected
    end

  end

  def resume_size_validation
    errors[:resume] << "should be less than 5MB" if resume.size > 5.megabytes
  end
end