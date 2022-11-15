class CreateAppoinments < ActiveRecord::Migration[5.0]
  def change
    create_table :appoinments do |t|
      t.datetime :date
      # t.references :doctor, foreign_key: true
      # t.references :patient, foreign_key: true
      #  t.references :time_slot, foreign_key: true

      t.timestamps
    end
  end
end
