class JobsController < ApplicationController


 def list
   @open_jobs = Job.active
end
  
end
