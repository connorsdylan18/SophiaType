Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "about", to: "about#index" 

  resources :extracts 

  get "typing_test", to: "typing_tests#index"
  get "typing_test/complete", to: "typing_tests#complete"

  post "/results", to: "results#create"

  get "/users/:user_id", to: "users#account_page", as: "user_account"
  get "/user_results/:user_id", to: "users#results", as: "user_results"
  get '/users/:user_id/edit', to: 'users#edit', as: 'edit_user'
  patch "/users/:user_id", to: "users#update", as: "user_update"

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "sign_in", to: "sessions#new", as: :new_session 
  post "sign_in", to: "sessions#create", as: :sign_in 

  delete "logout", to: "sessions#destroy", as: :logout

  root "main#index" 
end
