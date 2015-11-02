Rails.application.routes.draw do

  root "messages#index"
  resources :contacts
  resources :messages, :only => [:index, :show, :create, :new]
end
