class AddColumnsToAppoinments < ActiveRecord::Migration[5.0]
  def change
    add_column :appoinments, :doctor_id, :integer
    add_column :appoinments, :patient_id, :integer
    add_column :appoinments, :time_slot_id, :integer
  end
end
