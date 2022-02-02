Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "usage#index"
  get 'usage', to: 'usage#index', as: :usage

end
