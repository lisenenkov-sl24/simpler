Simpler.application.routes do
  get '/tests', 'tests#index'
  get '/test/:id', 'tests#show'
  get '/plain_tests', 'tests#plain'
  get '/json_tests', 'tests#json'
  post '/tests', 'tests#create'
end
