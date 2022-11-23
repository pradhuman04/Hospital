class TimeSlot < ApplicationRecord
  has_many :appoinments

  validates :slot, presence: true, inclusion: { in: %w(9:00AM 11:00AM 1:00PM 3:00PM 5:00PM 7:00PM 9:00PM) }  
end
