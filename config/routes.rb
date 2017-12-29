Akn::Application.routes.draw do


  get "calendars/index"

  get "calendars/show"

  get "calendars/edit"

  get "calendars/update"

 scope "(:locale)", locale: /en|de/ do
    match '/help', to: 'home_pages#help'
    match '/about', to: 'home_pages#about'
    match '/contact', to: 'home_pages#contact'
    match '/signup', to: 'users#new'


    get "login" => "sessions#new", as: "login"
    post "sessions" => "sessions#create", as: "sessions"
    delete "logout" => "sessions#destroy", as: "logout"

    get "reports/input", as: :input
    get "reports/admperiod", as: :admperiod
    get "reports/statistics", as: :statistics
    post "reports/output", as: :output
    post "reports/admout", as: :admout
    post "reports/yearstats", as: :yearstats
    get "reports/excel", as: :excel
    get "reports/output"
    get "reports/yearstats"
    get "reports/sel"

    get "reports/pdf", as: :pdf
    post "reports/output_pdf", as: :output_pdf



    resources :tasks do
      collection do
        get ':id/report' => 'tasks#report', as: 'report'
      end
    end

    resources :users do
      collection do
        get ':id/report' => 'users#report', as: 'report'
      end
    end

    resources :works do
      collection do
        get ':id/finalize' => 'works#finalize', as: 'finalize'
      end
    end


    resources :clients
    resources :projects
   resources :reports, only:  :create
 end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  get '/:locale' => 'home_pages#home'
  root :to => 'home_pages#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
