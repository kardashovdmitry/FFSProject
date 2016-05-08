Rails.application.routes.draw do
  #resources :attachments
  resources :attachments do
    collection { post :parse }
    collection { post :display_graphics }
  end
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :measurement_groups
  resources :devices
  resources :measurements
  resources :samples
  resources :researchers
  resources :raw_datums
  resources :description_for_rds


  #resources :measurement_groups, shallow: true do
  #  resources :devices
  #end
end

