Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :experiences, only: %i[index show new create] do
    resources :tasks, only: %i[show new create]
  end
  resources :users, only: %i[show] do
    resources :user_tasks, only: %i[index show new create]
  end

end
