class Note < ApplicationRecord
  belongs_to :user
  belongs_to :appoinment

  validates :description, presence: true
end
