class User < ApplicationRecord
  enum role: [:patient, :doctor]
  enum gender: [:male, :female, :others]

  # self.inheritance_column = :user_type
  

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
  #           presence: true,
  #           uniqueness: true,
  #           format: { with: EMAIL_REGEX, message: 'check e-mail format (abc123@example.com)' }

  # validates :password,
  #   presence:true,
  #   length: { minimum:6, maximum:20 }     
    
  
  validate  :validate_birth_date
  
  has_many :patient_appointments, class_name: "Appointment", foreign_key: :doctor_id, dependent: :destroy do
    def future
      where('status = :pending OR status = :cancelled', pending: Appointment.statuses[:pending],
                      cancelled: Appointment.statuses[:cancelled])
    end
  end

  has_many :doctor_appointments, class_name: "Appointment", foreign_key: :patient_id, dependent: :destroy do
    def future
      where('status = :pending OR status = :cancelled', pending: Appointment.statuses[:pending],
                      cancelled: Appointment.statuses[:cancelled])
    end
  end

  has_many :doctor_specifications, class_name: "DoctorSpecification", foreign_key: :doctor_id, dependent: :destroy
  belongs_to :general_room, class_name: :"GeneralRoom", foreign_key: 'patient_id'
  has_many :notes, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :get_all_doctors, -> { (select('id, first_name').where('role = :user_role', user_role: User.roles[:doctor])) }

  def future_appointments 
    
    result = patient_appointments.future.includes(:patient) if doctor?
    result = doctor_appointments.future.includes(:doctor) if patient?
    result
  end
  


  private

  def validate_birth_date 
    errors.add(:date_of_birth, "please put a valid date") if date_of_birth > Time.now
  end
end
