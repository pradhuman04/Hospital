class User < ApplicationRecord
  enum role: [:patient, :doctor]
  enum gender: [:male, :female, :others]

  NAME_REGEX = /\A[^0-9`!@#\$%\^&*+_=]+\z/
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  has_many :patient_appoinments, class_name: "Appoinment", foreign_key: :doctor_id, dependent: :destroy
  has_many :doctor_appoinments, class_name: "Appoinment", foreign_key: :patient_id, dependent: :destroy
  has_many :notes, dependent: :destroy

  validates :first_name,
            presence: true,
            length: { minimum:2, maximum:15},
            format: { with: NAME_REGEX, message: 'only letters are allowed' }

 validates :last_name,
            presence: true,
            length: { minimum:2, maximum:15 },
            format: { with: NAME_REGEX, message: 'only letters are allowed' }

  # validates :email,
  #           presence: true,
  #           uniqueness: true,
  #           format: { with: EMAIL_REGEX, message: 'check e-mail format (abc123@example.com)' }

  validates :password,
            presence:true,
            length: { minimum:6, maximum:20 }     
            
  validates_confirmation_of :password
  validate  :validate_birth_date

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :get_all_doctors, -> { (select('id, first_name').where('role = :user_role', user_role: User.roles[:doctor])) }

  def future_appoinments
    result = patient_appoinments.future.include(:patient) if doctor?
    result = doctor_appoinments.future.include(:doctor) if patient?
    
  end
  private

  def validate_birth_date 
    errors.add(:date_of_birth, "please put a valid date") if date_of_birth > Time.now
  end
end
