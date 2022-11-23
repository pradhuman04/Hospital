class Note < ApplicationRecord
  VALID_CONTENT_REGEX = /\A[a-zA-Z0-9\s]+\z/i
  validates :description, presence: true, format: { with: VALID_CONTENT_REGEX, message: "can only contain letters and numbers." }

  belongs_to :appointment
  belongs_to :user
end
