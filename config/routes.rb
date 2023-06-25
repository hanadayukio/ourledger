Rails.application.routes.draw do
  devise_for :user, controllers: {
    sessions: 'user/sessions',
    passwords: 'user/passwords',
    registrations: 'user/registrations'
  }
  devise_scope :user do
    get '/user/sign_out' => 'devise/sessions#destroy'
  end
  resources :users, only: [:index, :new, :edit, :show]
  
  devise_for :admin, skip: [:passwords, :registrations], controllers: {
    sessions: 'admin/sessions'
  }
  devise_scope :admin do
    get '/admin/sign_out' => 'devise/sessions#destroy'
  end

    
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/' => 'user/homes#top', as: 'top_page'
  get '/admin/top' => 'admin/homes#top', as: 'admin_top_page'
  
  # 管理者台帳
  namespace :admin do
    resources :registers, path: '/registers', only: [:new, :index, :show, :edit, :update]
  end
  post 'admin/register/new' => 'admin/registers#create', as: 'create_admin_register'
  # ユーザー台帳
  namespace :user do
    resources :registers, path: '/registers', only: [:index] do
      resources :equipments do
        resources :comments, only: [:create]
      end
    end
  end
end
