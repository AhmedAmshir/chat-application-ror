Rails.application.routes.draw do
  
  namespace :api do
    
    get '/applications', to: 'applications#index'
    post '/applications/create', to: 'applications#create'
    get '/applications/:token', to: 'applications#show'
    patch '/applications/:token/edit', to: 'applications#update'
    delete '/applications/:token/delete', to: 'applications#destroy'

    get '/applications/:token/chats', to: 'chats#index'
    post '/applications/:token/chats/create', to: 'chats#create'
    delete '/applications/:token/chats/:number/delete', to: 'chats#destroy'

    get '/applications/:token/chats/:number/messages', to: 'messages#index'
    post '/applications/:token/chats/:number/messages/create', to: 'messages#create'
    get '/applications/:token/chats/:number/messages/search', to: 'messages#search'
    get '/applications/:token/chats/:number/messages/:msg_number', to: 'messages#show'
    patch '/applications/:token/chats/:number/messages/:msg_number/edit', to: 'messages#update'
    delete '/applications/:token/chats/:number/messages/:msg_number/delete', to: 'messages#destroy'

  end  

end
