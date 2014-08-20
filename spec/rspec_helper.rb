require 'rspec'
require 'pg'
require 'author'
require 'title'
require 'contribution'

DB = PG.connect({:dbname => 'library'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM authors *;')
    DB.exec('DELETE FROM titles *;')
    DB.exec("DELETE FROM contributions *;")
  end
end
