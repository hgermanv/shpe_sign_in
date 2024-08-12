class Event < ApplicationRecord
    has_many :event_attendances, dependent: :destroy
    has_many :students, through: :event_attendances
  
    validates :name, presence: true
    validates :date, presence: true
  end
  