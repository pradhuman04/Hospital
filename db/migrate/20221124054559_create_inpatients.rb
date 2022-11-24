class CreateInpatients < ActiveRecord::Migration[5.0]
  def change
    create_table :inpatients do |t|
      t.references :room, foreign_key: true
      t.date :admission_date
      t.date :discharge_date
      t.timestamps
    end
  end
end
