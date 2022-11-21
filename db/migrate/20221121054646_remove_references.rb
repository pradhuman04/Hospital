class RemoveReferences < ActiveRecord::Migration[5.0]
  def change
    remove_column :notes, :appoinment_id, index: true, foreign_key: true
  end
end
