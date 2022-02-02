Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :list
      get :purchased
    end
  end
  # メモ
  # updateのリクエスト方式をpostからputchに変更できそうであればresourcesのupdateで処理する。そうでなければupdateは削除する
  resources :purchases, only: [:create, :destroy, :update]
  post '/purchases/:id(.:format)' => "purchases#update"

end
