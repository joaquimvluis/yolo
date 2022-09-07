Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"

  root to: "experiences#index"

  get 'results', to: "experiences#results", as: :results

  resources :experiences, only: %i[show new create] do
    resources :tasks, only: %i[show new create edit update]
  end

  resources :users, only: %i[index show edit update] do
    resources :user_tasks, only: %i[show index new create]
  end

  resources :user_tasks, only: %i[update destroy] do
    collection do
      get 'completed', 'open'
    end
  end

end
