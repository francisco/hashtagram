Hashtagram::Application.routes.draw do
  root to: "hashes#index"
  resources :hashes

 end
