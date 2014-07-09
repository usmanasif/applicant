class AddColumnToApplicant < ActiveRecord::Migration
  def change
    add_column :applicants,:cover_letter,:text
  end
end
