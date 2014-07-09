class AddColumnsToApplicants < ActiveRecord::Migration
  def change
    add_column :applicants,:expected_salary,:string
    add_column :applicants,:institute_name,:string
    add_column :applicants,:languages,:string
  end
end
