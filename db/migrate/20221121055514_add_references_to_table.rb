class AddReferencesToTable < ActiveRecord::Migration[5.0]
  def change
    add_reference :notes, :appointment, index: true, foreign_key: true
  end
end
