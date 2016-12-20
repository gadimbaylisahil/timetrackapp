Rails.application.routes.draw do
  resources :posts
  devise_for :users, skip: [:registrations] #removing sign up functionality from devise
  root to: 'static#homepage'
end
