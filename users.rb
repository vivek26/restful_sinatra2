require 'sinatra/base'
class Users<Sinatra::Base

end

Users.get '/' do
  'this is coming from  users'
end
Users.set :port,7979
Users.run!


