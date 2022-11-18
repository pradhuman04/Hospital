class DoctorSpecification < ApplicationRecord
    
    belongs_to :doctor, class_name: :"user"
end
