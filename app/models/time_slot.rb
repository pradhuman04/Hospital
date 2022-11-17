class TimeSlot < ApplicationRecord
  has_many :appoinments

  validates :slot, presence: true, inclusion: { in: %W (9:00 11:00 1:00 3:00 5:00 7:00 9:00) }
  
end
