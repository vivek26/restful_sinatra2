require 'sinatra'
require 'json'
set :port,4548
accounts=[]
accounts<<{:id=>'0001',:name=>'Cash',:balance=>1000,:type=>'asset'}
accounts<<{:id=>'0002',:name=>'Capital',:balance=>1000,:type=>'liability'}
accounts<<{:id=>'1110',:name=>'Accounts Receivable',:balance=>0,:type=>'asset'}
before do
  content_type :json
end

get '/accounts' do
  accounts.to_json
end

post '/accounts' do
  id=params[:id]
  name=params[:name]
  type=params[:type]
  accounts<<{:id=>id,:name=>name,:balance=>0,:type=>type}
  status 201
  {:response=>:success}
end







