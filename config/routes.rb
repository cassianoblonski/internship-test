Rails.application.routes.draw do
  post 'map', to: 'map#create'
  get '/cheaper_route/:map_name/:initial_point/:destination/:cost', to: 'cheaper_route#find_cheaper_route', cost: /\d+/
end
