class Appointment < ApplicationRecord
  validates :doctor_id, presence: true
  validates :patient_id, presence: true
  validates :date, presence: true
  validate  :validate_appoinment_date
  validates :time_slot_id, presence: true

  enum status: %i[pending accepted cancelled]

  belongs_to :doctor, class_name: 'User', foreign_key: 'doctor_id'
  belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'
  belongs_to :time_slot
  has_one :note, dependent: :destroy
  accepts_nested_attributes_for :note, allow_destroy: true

  private

  def validate_appoinment_date
    if date.present?
    errors[:date] << 'please put a valid date' if date < Time.zone.now 
    end
  end
end
