Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'home#index'
  get('login', :to => 'session#login')
  post('login', :to => 'session#create')
  get('get_stock', :to => 'users#get_stock')
  delete('login', :to => "session#destroy")
  post('message', :to => "message#create" )
  resource('users')
  mount ActionCable.server, at: '/cable'
  
end
