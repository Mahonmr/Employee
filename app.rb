require("sinatra")
require("sinatra/reloader")
require("sinatra/activerecord")
also_reload("lib/**/*.rb")
require("./lib/division")
require("./lib/employee")
require("./lib/project")
require("./lib/employee_projects")
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

get('/divisions/:id/staff') do
  @division = Division.find(params.fetch("id").to_i)
  erb(:division_staff)
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

get('/projects') do
  @projects = Project.all()
  erb(:projects)
end

get('/projects/new') do
  @projects = Project.all()
  erb(:project_new)
end

post('/projects') do
  Project.create(params).save
  redirect ('/projects')
end

get('/projects/:id/delete') do
  @project = Project.find(params.fetch("id").to_i)
  @project.delete
  redirect ('/projects')
end

get('/projects/:id/assign') do
  @project = Project.find(params.fetch("id").to_i)
  erb(:project_assign)
end

patch('/projects/:project_id/assign') do
  EmployeesProject.create(:employee_id => params.fetch("employee_id").to_i, :project_id => params.fetch("project_id").to_i).save
  redirect ('/projects')
end

# patch("/projects/:id") do
#   employee_id = params.fetch("employee_id")
#   @project = Project.find(params.fetch("id").to_i)
#   @project.update({:employee_id => employee_id})
#   redirect ('/projects')
# end
