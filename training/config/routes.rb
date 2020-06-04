Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks do
    collection do
      get :search
    end
  end
  resources :sessions, only: [:new, :create]

  # どのルーティングにもマッチしなかったら、404ページにリダイレクト
  get '*path', controller: 'application', action: 'rescue404'
end
