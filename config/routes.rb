Rails.application.routes.draw do
  resources :creature_forms
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'welcome/index'

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Auth routes
  get '/login' => 'auth#new', as: :login
  post '/login' => 'auth#login'
  get '/logout' => 'auth#logout', as: :logout

  # Users Routes
  resources :users

  # Rules Routes
  # Import routes
  get 'rules_pages/import' => 'rules_pages#import', as: :import
  post 'rules_pages/import' => 'rules_pages#import'
  # Search Rules route
  get '/search' => 'rules_pages#search', as: :search

  # Table of Contents routes
  get '/edit' => 'welcome#edit', as: :homepage_edit
  post '/update' => 'welcome#update', as: :homepage_update
  patch '/update' => 'welcome#update', as: :homepage_update2

  # Nest the routes for subpages and comments within rules pages
  resources :rules_pages do
    resources :subpages
    resources :comments
  end

  # Auction System Routes
  resources :games, only: [:show, :index, :new, :create] do
    resources :characters, only: [:show, :index, :new, :create, :destroy]
    resources :char_rounds, only: [:new, :create, :destroy]
    member do
      get 'start'
      get 'gm'
      post 'aspect'
      post 'gift'
      post 'close' #close round
      post 'close_auction' #close auction
      get 'close_auction' #close auction
      post 'display' # change between Ranks and Points Displayed
    end
    get 'player' => 'char_rounds#new', as: :player
  end

  # Character System Routes
  resources :character_systems, only: [:show, :index, :new, :create] do
    resources :final_characters, only: [:show, :edit, :update] do
      post 'submit'
      post 'reject'
      post 'approve'
      get 'wishes'
      post 'save_wishes'
    end
    resources :tools, only: [:show, :new, :edit, :create, :update, :destroy]
    resources :regencies, only: [:show, :new, :edit, :create, :update, :destroy]
    resources :flaws, only: [:index, :new, :create, :destroy]
    resources :wishes, only: [:index, :new, :create, :destroy]
    resources :char_trees
    resources :creature_forms, only: [:show, :new, :edit, :create, :update, :destroy]
  end
  resources :abilities

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".



  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

end
