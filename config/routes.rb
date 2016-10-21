Rails.application.routes.draw do
  devise_for :users
 # match 'courses/register', to: 'courses#register', :via => 'get'
  resources :courses




  root "courses#index"
  # For details on the DSL '/available within this file, see http://guides.rubyonrails.org/routing.html
end
