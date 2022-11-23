class Appointment < ApplicationRecord
  validates :doctor_id, presence: true
  validates :patient_id, presence: true
  # validates :date, presence: true

  # validate  :validate_appoinment_date
  validates   :time_slot_id, presence: true

  enum status: [:pending, :unvisited, :cancelled, :visited]

  belongs_to :doctor, class_name: "User", foreign_key: 'doctor_id'

  belongs_to :patient, class_name: "User", foreign_key: 'patient_id'

  # belongs_to :time_slot
  
  has_many :notes, dependent: :destroy

  def self.get_current_status(date)
    return Appointment.statuses[:pending] if date > Time.now
    return Appointment.statuses[:unvisited] if date > Time.now
  end

  private
  
#   def validate_appoinment_date
#     errors.add(:date, "please put a valid date")if date < Time.now
#   end
end
