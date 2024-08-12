class EventAttendance < ApplicationRecord
  belongs_to :student
  belongs_to :event

  validates :attended_on, presence: true
end
