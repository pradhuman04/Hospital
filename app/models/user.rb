class User < ApplicationRecord
  enum role: [:patient, :doctor]
  has_many :patient_appoinments, class_name: "Appoinment", foreign_key: :doctor_id, dependent: :destroy
  has_many :doctor_appoinments, class_name: "Appoinment", foreign_key: :patient_id, dependent: :destroy
  has_many :notes, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
