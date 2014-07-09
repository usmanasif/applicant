class AddApplicantsTable < ActiveRecord::Migration
  def up
    create_table :applicants do |t|
      t.string :full_name
      t.date :dob
      t.string  :email,:uniqe=>true
      t.string :phone
      t.string :experience
      t.text :experience_description
      t.text :education
      t.string :resume
      t.float :cgpa
      t.date :available_at
      t.timestamps
    end
  end

  def down
    drop_table :applicants
  end
end
