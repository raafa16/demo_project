Rails.application.routes.draw do
  resources :semesters
  get 'users/show'

  devise_for :users, :path => '', :path_names => {:sign_in => 'sign-in', :sign_out => 'sign-out'}
  resources :users, only: [:show]
  match 'courses/register', to: 'courses#register', :via => 'post'
  match 'courses/confirmed_grade_submission', to: 'courses#confirmed_grade_submission', :via => 'post'
  #match 'courses/publish_grade', to: 'courses#publish_grade', :via => 'post'
  #match 'courses/drop', to: 'courses#drop', :via => 'post'


  get 'users/:id' => 'users#show'

  resources :courses do
    collection do
      get :confirmed_registration
      get :drop
      get :publish_grade
      post :search
    end


  end

  root "courses#index"
  # For details on the DSL '/available within this file, see http://guides.rubyonrails.org/routing.html
end
