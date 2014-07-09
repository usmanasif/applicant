class AddJobsTable < ActiveRecord::Migration
  def up
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.date  :end_date
      t.string :min_experience
      t.integer :salary
      t.timestamps
    end
  end

  def down
    drop_table :jobs
  end
end
