Marx::Application.routes.draw do
  devise_for :users
  root :to => "users#sign_in"
end
