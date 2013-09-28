Marx::Application.routes.draw do
  resources :pages, only: [:create, :update, :delete]
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root :to => "home#index"
end
