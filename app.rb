require("sinatra")
require("sinatra/reloader")
require("sinatra/activerecord")
also_reload("lib/**/*.rb")
require("./lib/")
require("./lib/")
require("pg")
require("pry")

get('/') do
  erb(:index)
end
