class RenameTableName < ActiveRecord::Migration[5.0]
  def change
    rename_table :appoinments, :appointments
  end
end
