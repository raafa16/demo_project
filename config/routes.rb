Rails.application.routes.draw do
  resources :semesters
  get 'users/show'

  devise_for :users
  resources :users, only: [:show]
 match 'courses/register', to: 'courses#register', :via => 'post'
  #match 'courses/drop', to: 'courses#drop', :via => 'post'


  get 'users/:id' => 'users#show'

  resources :courses do
    collection do
      get :confirmed_registration
      get :drop

    end


  end








  root "courses#index"
  # For details on the DSL '/available within this file, see http://guides.rubyonrails.org/routing.html
end
