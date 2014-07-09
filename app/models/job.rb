class Job < ActiveRecord::Base
  attr_accessible :status,:title,:description,:end_date,:min_experience,:salary
  has_many :applicants


  scope :active, lambda {where("jobs.status = '1' ") }
  scope :deactive, lambda {where("jobs.status = '0' ") }
end