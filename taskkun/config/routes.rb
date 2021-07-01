Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'tasks#index'
  resources :tasks

  get '*not_found' => 'errors#routing_error'
  post '*not_found' => 'errors#routing_error'

  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :tasks
    end
  end
end
