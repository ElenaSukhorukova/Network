Rails.application.routes.draw do
  devise_for :users
  get 'static_pages/about'
  get 'static_pages/rules'
  get 'static_pages/contacts'

  root to: "static_pages#about"
end
