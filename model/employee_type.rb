class EmployeeType < ActiveRecord::Base
    validates :initials, presence: true
    validates :description, presence: true
end