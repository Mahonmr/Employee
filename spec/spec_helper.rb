ENV['RACK_ENV'] = 'test'
require("rspec")
require("pg")
require("")
require("")
require('pry')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM  *;")
    DB.exec("DELETE FROM  *;")
    DB.exec("DELETE FROM  *;")
  end
end
