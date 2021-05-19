Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tasks#index'

  resources :tasks
<<<<<<< HEAD

  # for error (unexist URL)
  get '*anything' => 'errors#routing_error'
=======
>>>>>>> rocky
end
