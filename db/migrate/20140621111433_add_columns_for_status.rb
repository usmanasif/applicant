class AddColumnsForStatus < ActiveRecord::Migration
  def up
    add_column :jobs,:status,:integer,:default=>1
    add_column :applicants,:status,:string,:default=>"New"
  end

  def down
    remove_column :jobs,:status
    remove_column :applicants,:status
  end
end
