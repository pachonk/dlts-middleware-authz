Rails.application.routes.draw do
  root 'test#home'
  get 'test/home'
  get '/auth/:provider/callback' => 'application#authentication_callback'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
