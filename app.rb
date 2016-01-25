require("sinatra")
require("sinatra/reloader")
require("sinatra/activerecord")
also_reload("lib/**/*.rb")
require("./lib/division")
require("./lib/employee")
require("pg")
require("pry")

get('/') do
  erb(:index)
end

get('/divisions') do
  @divisions = Division.all()
  erb(:divisions)
end

get('/divisions/new') do
  erb(:division_new)
end

get('/divisions/:id') do
  @division = Division.find(params.fetch("id").to_i)
  erb(:division_page)
end

get('/divisions/:id/edit') do
  @division = Division.find(params.fetch("id").to_i)
  erb(:division_edit)
end

post('/divisions') do
  Division.create(params).save
  redirect ('/divisions')
end

patch("/divisions/:id") do
  name = params.fetch("name")
  @division = Division.find(params.fetch("id").to_i)
  @division.update({:name => name})
  redirect ('/divisions')
end

get('/divisions/:id/delete') do
  @division = Division.find(params.fetch("id").to_i)
  @division.delete
  redirect ('/divisions')
end

#start employee routes

get('/employees') do
  @employees = Employee.all()
  erb(:employees)
end

get('/employees/new') do
  @employees = Employee.all()
  erb(:employee_new)
end

get('/employees/:id') do
  @employee = Employee.find(params.fetch("id").to_i)
  erb(:employee_page)
end

post('/employees') do
  Employee.create(params).save
  redirect ('/employees')
end

get('/employees/:id/delete') do
  @employee = Employee.find(params.fetch("id").to_i)
  @employee.delete
  redirect ('/employees')
end

get('/employees/:id/assign') do
  @employee = Employee.find(params.fetch("id").to_i)
  erb(:employee_assign)
end

patch("/employees/:id") do
  division_id = params.fetch("division_id")
  @employee = Employee.find(params.fetch("id").to_i)
  @employee.update({:division_id => division_id})
  redirect ('/employees')
end
