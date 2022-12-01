class DoctorSpecification < ApplicationRecord
  NAME_REGEX = /\A[^0-9`!@#$%\^&*+_=]+\z/

  validates :specialization, presence: true, length: { minimum: 2, maximum: 15 },
                             format: { with: NAME_REGEX, message: 'only letters are allowed' }

  validates :institute_name, presence: true, length: { minimum: 2, maximum: 20 },
                             format: { with: NAME_REGEX, message: 'only letters are allowed' }

  validates :clinic_address, presence: true, length: { minimum: 2, maximum: 40 }

  
  validate  :validate_practicing_from

  belongs_to :doctor, class_name: :User, foreign_key: 'doctor_id'

  private

  def validate_practicing_from
    if practicing_from.present?
    errors.add(:practicing_from, 'please put a valid date') if practicing_from > Time.zone.now 
  end
end
end
