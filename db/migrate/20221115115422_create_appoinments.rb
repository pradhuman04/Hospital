class CreateAppoinments < ActiveRecord::Migration[5.0]
  def change
    create_table :appoinments do |t|
      t.datetime :date

      t.timestamps
    end
  end
end
