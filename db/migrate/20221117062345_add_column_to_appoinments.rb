class AddColumnToAppoinments < ActiveRecord::Migration[5.0]
  def change
    add_column :appoinments, :status, :integer
  end
end
