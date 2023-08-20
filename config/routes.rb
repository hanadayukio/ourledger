Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  devise_for :user, controllers: {
    sessions: 'user/sessions',
    passwords: 'user/passwords',
    registrations: 'user/registrations'
  }
  devise_scope :user do
    get '/user/sign_out' => 'devise/sessions#destroy'
  end
  
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
    passwords: 'admin/passwords',
    registrations: 'admin/registrations'
  }
  devise_scope :admin do
    get '/admin/sign_out' => 'devise/sessions#destroy'
  end

# ホーム画面
  get '/' => 'home/homes#top', as: 'top_page'
  get '/about' => 'home/homes#about', as: 'about_page'
  get '/home' => 'user/homes#top', as: 'user_home_page'
  get '/admin/home' => 'admin/homes#top', as: 'admin_home_page'
  
  # 管理者台帳
  namespace :admin do
    resources :registers, path: '/registers', only: [:index, :show, :edit, :update]
    get '/register/new', to: 'registers#new', as: 'new_register'
    resources :users, path: '/users', only: [:new, :index, :show, :edit, :update, :create]
  end

  post 'admin/register/new' => 'admin/registers#create', as: 'create_admin_register'
  # ユーザー台帳
  namespace :user do
    resources :registers, path: '/registers', only: [:index] do
      # ユーザー機器/コメント
      resources :equipments do
        resources :comments, only: [:create], controller: 'equipment/comments'
         # 機器変更履歴
        resources :change_logs, only: [:create, :index], controller: 'equipment/change_logs'
      end
    end
  end
end
