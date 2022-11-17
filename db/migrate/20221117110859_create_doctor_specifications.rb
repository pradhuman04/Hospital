class CreateDoctorSpecifications < ActiveRecord::Migration[5.0]
  def change
    create_table :doctor_specifications do |t|
      t.string :specialization
      t.string :institute_name
      t.datetime :practicing_from
      t.string :clinic_address
      t.integer :doctor_id
      t.timestamps
    end
  end
end
