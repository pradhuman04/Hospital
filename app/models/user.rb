class User < ApplicationRecord

  enum role: [:patient, :doctor]
  enum gender: [:male, :female, :others]
  
  NAME_REGEX = /\A[^0-9`!@#\$%\^&*+_=]+\z/
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # validates :first_name,
  # presence: true,
  # length: { minimum:2, maximum:15},
  # format: { with: NAME_REGEX, message: 'only letters are allowed' }

  # validates :last_name,
  #   presence: true,
  #   length: { minimum:2, maximum:15 },
  #   format: { with: NAME_REGEX, message: 'only letters are allowed' }

    # validates :email,
    #   presence: true,
    #   uniqueness: true,
    #   format: { with: EMAIL_REGEX, message: 'check e-mail format (abc123@example.com)' }

  # validates :password,
  #   presence:true,
  #   length: { minimum:6, maximum:20 }     
  
  validate  :validate_birth_date
  
  has_many :patient_appointments, class_name: "Appointment", foreign_key: :patient_id, dependent: :destroy
  
  has_many :doctor_appointments, class_name: "Appointment", foreign_key: :doctor_id, dependent: :destroy
  

  has_many :doctor_specifications, class_name: "DoctorSpecification", foreign_key: :doctor_id, dependent: :destroy
  
  has_many :notes, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :get_all_doctors, -> { (select('id, first_name').where('role = :user_role', user_role: User.roles[:doctor])) }
  scope :get_all_patients, -> { (select('id, first_name').where('role = :user_role', user_role: User.roles[:patient])) }


  private

  def validate_birth_date 
    errors.add(:date_of_birth, "please put a valid date") if date_of_birth > Time.now
  end
end
