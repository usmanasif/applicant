class UpdateTable < ActiveRecord::Migration
  def change
    remove_column :jobs,:salary
    add_column :jobs,:salary,:string

    add_column :applicants,:job_id,:integer
  end
end
