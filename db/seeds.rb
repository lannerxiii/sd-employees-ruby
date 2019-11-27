require './model/employee'
require './model/employee_type'

EmployeeType.create(initials: 'MANT', description: 'Area de mantenimiento')
EmployeeType.create(initials: 'LIMP', description: 'Area de limpieza')

Employee.create(first_name: 'Juan', surname: 'Perez', email: 'juanperez@gmail.com', password: '1234', employee_type_id: '1')
Employee.create(first_name: 'Carlos', surname: 'Fernandez', email: 'carlosfernandez@gmail.com', password: '1234', employee_type_id: '1')
Employee.create(first_name: 'Roberto', surname: 'Gonzalez', email: 'robertogonzalez@gmail.com', password: '1234', employee_type_id: '1')