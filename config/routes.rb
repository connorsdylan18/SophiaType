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

  get "password", to: "passwords#edit", as: :edit_password
  patch "password", to: "passwords#update"

  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
  get "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"


  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "logout", to: "sessions#destroy"

  root "main#index" 
end
