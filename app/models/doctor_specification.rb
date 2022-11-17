class DoctorSpecification < ApplicationRecord
    
    belongs_to :doctor, class_name: :"user", foreign_key: 'patient_id'
end
