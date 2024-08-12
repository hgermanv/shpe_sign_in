class Student < ApplicationRecord
    has_many :event_attendances
    has_many :events, through: :event_attendances
  
    validates :email, presence: true, uniqueness: true
    validates :name, presence: true
    validates :year, presence: true
  
    before_create :initialize_attendance_points
  
    private

    def self.search(query)
      where("name LIKE ? OR email LIKE ? OR major LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
    end
  
    def initialize_attendance_points
      self.attendance_points ||= 1
    end
  end
  