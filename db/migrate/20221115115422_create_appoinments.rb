class CreateAppoinments < ActiveRecord::Migration[5.0]
  def change
    create_table :appoinments do |t|
      t.date :date
      t.references :doctor, foreign_key: true
      t.refereces :patient, foreign_key: true
      t.references :time_slot, foreign_key: true

      t.timestamps
    end
  end
end
