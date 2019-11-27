require "sinatra"
require "sinatra/activerecord"
require "sinatra/reloader"
require "sinatra/param"
require "json"
require "./model/employee"
require "./model/employee_type"

set :database_file, 'config/db.yml'
set :show_exceptions, false
set :raise_errors, false

error   do
 env['sinatra.error']
end 

error 404 do 
  'No existe la ruta'.to_json
end

set :port, 4568

before do
  content_type :json
  if (request.request_method == "POST" || request.request_method == "PUT") && request.content_type == "application/json"
    body_paramenters = request.body.read
    begin
      params.merge!(JSON.parse(body_paramenters))
    rescue JSON::ParserError
      halt 400, { 'Content-Type' => 'application/json'},
                "Formato de JSON Incorrecto".to_json
    end
  end
end
get '/' do
  content_type :html
  File.read(File.join('public', 'index.html'))
end

get '/employees' do
  
  Employee.all.to_json(:include=>:employee_type)
end

get '/employee/:id' do
  param :id, Integer, required: true, message: "no"
  if Employee.exists?(params['id'])
    Employee.find(params['id']).to_json(:except => 'password')
  else 
   "No existe el empleado con el ID #{params['id']}".to_json
  end
end

get '/employee-by-type/:typeId' do
  if !EmployeeType.exists?(params['typeId'])
    'No existe ese tipo de empleado'.to_json
  else
    ept = Employee.joins(:employee_type).where('employee_types.id = ?',params['typeId'])
    if ept.blank?
      "No se encontraron empleados con el tipo #{params['typeId']}".to_json
    else
      ept.to_json
    end
  end
end

post '/employee' do
  param :first_name, String, required: true
  param :surname, String, required: true
  param :email, String, required: true, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: 'Formato de mail invalido'
  param :password, String, required: true
  param :employee_type_id, Integer, required: true
  
 
  employee = Employee.create(params.slice(:first_name,:surname,:email,:password,:employee_type_id))
  if employee.valid? 
    employee.to_json
  else
    employee.errors.to_json
  end
end

put '/employee/:id' do
  param :id, Integer, required: true
  param :first_name, String, required: true
  param :surname, String, required: true
  param :password, String, required: true
  param :employee_type_id, Integer, required: true

  if Employee.exists?(params['id'])
    employee = Employee.find(params['id'])
    employee.update(params.slice(:first_name, :surname,:password,:employee_type_id))
    if employee.valid?
      employee.to_json
    else
      employee.errors.to_json
    end
  else
    "No se encontró un empleado con el ID #{params['id']}".to_json
  end
end

delete '/employee/:id' do

  if !Employee.exists?(params['id'])
    "No se encontró un empleado con el ID #{params['id']}".to_json
  else
    Employee.destroy(params['id'])
    'Empleado borrado exitosamente'.to_json
  end
end

get '/employee-types' do
  EmployeeType.all.to_json
end

get '/employee-type/:id' do
  if !EmployeeType.exists?(params['id'])
    "No se encontró un tipo empleado con el ID #{params['id']}".to_json
  else
    EmployeeType.find(params['id']).to_json
  end
end

post '/employee-type' do
  param :initials, String, required: true
  param :description, String, required: true
  
  EmployeeType.create(params.slice(:initials,:description)).to_json
end

put '/employee-type/:id' do
  param :id, Integer, required: true
  param :initials, String, required: true
  param :description, String, required: true

   if !EmployeeType.exists?(params['id'])
      "No se encontró un tipo empleado con el ID #{params['id']}".to_json
    else
      ept = EmployeeType.find(params['id'])
      ept.update(params.slice(:initials,:description)).to_json
      if ept.valid?
        ept.to_json
      else
        ept.errors.to_json
      end
    end
end

delete '/employee-type/:id' do
  if !EmployeeType.exists?(params['id'])
    "No se encontró un tipo empleado con el ID #{params['id']}".to_json
  else
    EmployeeType.destroy(params['id'])
    "Tipo de empleado borrado exitosamente (ID #{params['id']})".to_json
  end
end

post '/login' do
  param :email, String, required: true
  param :password, String, required: true
  
  emp = Employee.where("email = ? AND password = ?", params['email'], params['password'])

  if emp.empty?
    {"success" => "false", "message" => "Las credenciales son inválidas"}.to_json
  else 
    {"success" => "true", "message" => "Las credenciales son válidas"}.to_json
  end
    
end
