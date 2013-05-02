Fastladder::Application.routes.draw do
  # --------------------------------------------------------------------------------
  # api/*
  # --------------------------------------------------------------------------------
  namespace 'api' do
    match 'pin/:action' => 'pin', via: :post

    match 'feed/discover'   => 'feed#discover', via: :get
    match 'feed/subscribed' => 'feed#subscribed', via: :get
    match 'feed/:action'    => 'feed', via: :post

    match 'folder/:action' => 'folder', via: :post

    match 'config/load' => 'config#getter', via: [:post, :get]
    match 'config/save' => 'config#setter', via: [:post]
  end

  %w(all unread touch_all touch item_count unread_count crawl).each do|name|
      match "api/#{name}" => "api\##{name}", via: :get
  end
  post 'api/:action' => 'api'

  # other API call routes to blank page
  match 'api/*_' => 'application#nothing', via: [:post, :get]

  # --------------------------------------------------------------------------------
  # other pages 
  # --------------------------------------------------------------------------------
  get 'subscribe', to: 'subscribe#index', as: :subscribe_index
  get 'subscribe/*url', to: 'subscribe#confirm', as: :subscribe, format: false
  post 'subscribe/*url', to: 'subscribe#subscribe', format: false
  match 'about/*url' => 'about#index', as: :about, format: false, via: :get
  match 'user/:login_name' => 'user#index', as: 'user', via: [:get, :post]
  match 'icon/*feed' => 'icon#get', via: [:get, :post]
  match 'favicon/*feed' => 'icon#get', via: [:get, :post]

  resource :members, only: :create
  get 'signup' => 'members#new', as: :sign_up

  resource :session, only: :create
  get 'login'  => 'sessions#new',     as: :login
  get 'logout' => 'sessions#destroy', as: :logout

  root to: 'reader#welcome'

  match 'reader' => 'reader#index', via: [:get, :post]
  match 'contents/guide' => 'contents#guide', via: [:get, :post]
  match 'contents/config' => 'contents#configure', via: [:get, :post]
  get 'share', to: 'share#index', as: 'share'

  get 'import', to: 'import#index'
  post 'import', to: 'import#fetch'
  get 'import/*url', to: 'import#fetch', format: false
  post 'import/finish', to: 'import#finish'
  get 'export/opml', to: 'export#opml', as: 'export'

  get 'account', to: 'account#index', as: 'account_index'
  get 'account/:action', to: 'account', as: 'account'

  match 'rpc/:action' => 'rpc', via: [:get, :post]

  get 'utility/bookmarklet' => "utility/bookmarklet#index"

  match ':controller(/:action(/:id))(.:format)', via: [:get, :post]
end
