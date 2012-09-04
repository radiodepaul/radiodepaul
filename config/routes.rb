RadioDePaulWebsite2::Application.routes.draw do
  if Rails.env == 'production'
    devise_for :people, :controllers => {:registrations => "registrations" }, :path => "/", :path_names => { :sign_in => 'login', :sign_out => 'logout' }
  else
    devise_for :people, :path => "/", :path_names => { :sign_in => 'login', :sign_out => 'logout' }
  end

  get 'people/become' => 'people#become'
  get 'people/reset_password' => 'people#reset_password'

  get 'people/send_welcome' => 'people#send_welcome'

  resources :settings

  resources :applications do
    get :autocomplete_genre_name, :on => :collection   
  end

  resources :apps, :controller => 'applications' do
    get :autocomplete_genre_name, :on => :collection   
  end

  resources :news_posts

  resources :podcasts

  get 'welcome' => 'pages#welcome', :as => 'welcome'

  get 'home' => 'pages#home', :as => 'home'

  get 'apps/hire/:id' => 'applications#hire', :as => 'applications_hire'

  #get "application/success" => 'pages#application_success', :as => 'application/success'

  get "pages/api"

  get 'application' => "applications#new", :as => '/application'

  resources :slots do
    collection do
      get 'current'
      get 'now_playing'
    end
  end

  get "api/getSchedule" => "slots#getSchedule", :as => "getSchedule"
  get "api/getOnAir" => "slots#getOnAir", :as => "getOnAir"
  get "api/shows/getShow" => "shows#getShow", :as => "getShow"
  get "api/shows/getList" => "shows#getList", :as => "getList"
  get "api/shows/getRandom" => "shows#getRandom", :as => "getRandom"
  get "api/people/getPerson" => "people#getPerson", :as => "getPerson"
  get "api/people/getList" => "people#getList", :as => "getList"
  get "api/people/getRandom" => "people#getRandom", :as => "getRandom"
  get "api/people/getManagers" => "managers#getManagers", :as => "getManagers"
  get "api/getPodcasts" => "podcasts#getPodcasts", :as => "getPodcasts"
  get "api/news_posts/getList" => "news_posts#getList", :as => "getList"
  get "api/news_posts/getPost" => "news_posts#getPost", :as => "getPost"

  resources :managers do
    collection do
      get 'random'
    end
  end

  resources :hostings
  
  resources :people do
    collection do
      get 'random'
      get 'search'
    end
  end

  resources :shows do
    collection do
      get 'random'
      get 'search'
      get :autocomplete_genre_name
    end
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
  root :to => 'pages#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
