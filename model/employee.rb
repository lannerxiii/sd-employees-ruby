class Employee < ActiveRecord::Base
    validates :email, uniqueness: { message: "El email ya existe"}, presence: true
    validates :password,   presence: true
    validates :first_name, presence: true
    validates :surname,    presence: true
    belongs_to :employee_type
    validates :employee_type, presence: { message: "No existe el tipo de empleado"}
end