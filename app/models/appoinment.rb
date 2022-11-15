class Appoinment < ApplicationRecord
  belongs_to :doctor, class_name: :"user", foreign_key: 'patient_id'
  belongs_to :patient,class_name: :"user", foreign_key: 'doctor_id'
  belongs_to :time_slot
  has_many  :notes, dependent: :destroy
end
