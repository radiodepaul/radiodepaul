RadioDePaulWebsite2::Application.routes.draw do
  match ':controller/options(/:id)', action: 'options', :constraints => {:method => 'OPTIONS'}

  namespace :api , defaults: { format: 'json' } do
    namespace :v2 do

      resources :shows do
        collection do 
          get 'random(/:limit)', action: :random, defaults: { limit: 1 }
        end
      end

      resources :people do
        collection do 
          get 'random(/:limit)', action: :random, defaults: { limit: 1 }
        end
      end

      resources :events
      resources :news_posts
      resources :slots
    end
  end

  # API v1
  get 'api/getSchedule' => 'slots#getSchedule', :as => 'getSchedule'
  get 'api/getOnAir' => 'slots#getOnAir', :as => 'getOnAir'
  get 'api/shows/getShow' => 'shows#getShow', :as => 'getShow'
  get 'api/shows/getList' => 'shows#getList', :as => 'getList'
  get 'api/shows/getRandom' => 'shows#getRandom', :as => 'getRandom'
  get 'api/people/getPerson' => 'people#getPerson', :as => 'getPerson'
  get 'api/people/getList' => 'people#getList', :as => 'getList'
  get 'api/people/getRandom' => 'people#getRandom', :as => 'getRandom'
  get 'api/people/getManagers' => 'managers#getManagers', :as => 'getManagers'
  get 'api/getPodcasts' => 'podcasts#getPodcasts', :as => 'getPodcasts'
  get 'api/news_posts/getList' => 'news_posts#getList', :as => 'getList'
  get 'api/news_posts/getPost' => 'news_posts#getPost', :as => 'getPost'

  resources :sports_events
  resources :events
  resources :awards
  resources :settings
  resources :news_posts
  resources :podcasts
  resources :hostings

  resources :applications do
    get :autocomplete_genre_name, on: :collection
    collection do
      put 'admin'
    end
  end

  resources :apps, :controller => 'applications' do
    get :autocomplete_genre_name, on: :collection
    collection do
      put 'admin'
    end
  end

  resources :slots do
    collection do
      get 'current'
      get 'now_playing'
    end
  end

  resources :managers do
    collection do
      get 'random'
    end
  end
  
  resources :people do
    collection do
      get 'random'
      get 'search'
      put 'admin'
    end
  end

  resources :shows do
    collection do
      get 'random'
      get 'search'
      get :autocomplete_genre_name
      put 'admin'
    end
  end

  if Rails.env == 'production'
    devise_for :people, :controllers => {:registrations => 'registrations' }, :path => '/', :path_names => { :sign_in => 'login', :sign_out => 'logout' }
  else
    devise_for :people, :path => '/', :path_names => { :sign_in => 'login', :sign_out => 'logout' }
  end

  get 'people/become' => 'people#become'
  get 'people/reset_password' => 'people#reset_password'
  get 'people/send_welcome' => 'people#send_welcome'
  get 'welcome' => 'pages#welcome', :as => 'welcome'
  get 'home' => 'pages#home', :as => 'home'
  get 'apps/hire/:id' => 'applications#hire', :as => 'applications_hire'
  get 'pages/api'
  get 'application' => 'applications#new', :as => '/application'

  root :to => 'pages#welcome'
end
