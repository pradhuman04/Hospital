class Appoinment < ApplicationRecord

  enum status: [:pending, :unvisited, :cancelled, :visited]

  belongs_to :doctor, class_name: :"user", foreign_key: 'patient_id'

  belongs_to :patient, class_name: :"user", foreign_key: 'doctor_id'

  belongs_to :time_slot
  
  has_many   :notes, dependent: :destroy

  def validate_appoinment_date
    errors.add(:date, "please put a valid date")if date > Time.now
  end
end
