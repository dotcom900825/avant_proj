Rails.application.routes.draw do
  resources :password_resets

  delete 'logout' => 'user_sessions#destroy', as: 'logout'
  resources :user_sessions

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'user_sessions#new'

  resources :visualization_paths

  resources :avant_data do
    get "time_data", on: :collection
    get "circle_packing", on: :collection
    get "pie_chart", on: :collection
    get "address", on: :collection
    get "bar_hierarchy", on: :collection
    get "zip", on: :collection
    get "three_digit_zip", on: :collection
    get "parallel", on: :collection
    get "cluster", on: :collection
    get "flexible_cluster", on: :collection
    get "all_data", on: :collection
    post "map_polylines", on: :collection
    get "scatter_chart", on: :collection
    get "demo_data", on: :collection

    get "geojson", on: :collection
    get "all", on: :collection
    get "geojson_example", on: :collection
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
