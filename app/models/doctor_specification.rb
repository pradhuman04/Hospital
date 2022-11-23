class DoctorSpecification < ApplicationRecord
  
	NAME_REGEX = /\A[^0-9`!@#\$%\^&*+_=]+\z/

    
	validates :specialization,
  presence: true,
  length: { minimum:2, maximum:15},
  format: { with: NAME_REGEX, message: 'only letters are allowed' }

	validates :institute_name,
  presence: true,
  length: { minimum:2, maximum:20},
  format: { with: NAME_REGEX, message: 'only letters are allowed' }

	validates :clinic_address,
  presence: true,
  length: { minimum:2, maximum:40},
  
  validates :birth_date, presence: true
	validate  :validate_birth_date
    
    belongs_to :doctor, class_name: :"User", foreign_key: 'doctor_id'


		private

  def validate_birth_date 
    errors.add(:practicing_from, "please put a valid date") if practicing_from > Time.now
  end
end
