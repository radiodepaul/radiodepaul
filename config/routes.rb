RadioDePaulWebsite2::Application.routes.draw do
  match ':controller/options(/:id)', action: 'options', constraints: {method: 'OPTIONS'}

  namespace :api , defaults: { format: 'json' } do
    namespace :v2 do

      resources :shows, except: [:new, :edit] do
        collection do
          get 'random(/:limit)', action: :random, defaults: { limit: 1 }
        end
      end

      resources :people, except: [:new, :edit] do
        collection do
          get 'random(/:limit)', action: :random, defaults: { limit: 1 }
        end
      end

      resources :events,     except: [:new, :edit]
      resources :news_posts, except: [:new, :edit]
      resources :slots,      except: [:new, :edit] do
        collection do
          get 'on_air'
          get 'random(/:limit)', action: :random, defaults: { limit: 1 }
        end
      end
    end
  end

  root :to => 'pages#welcome'

  get 'people/become' => 'people#become'
  get 'people/reset_password' => 'people#reset_password'
  get 'people/send_welcome' => 'people#send_welcome'
  get 'welcome' => 'pages#welcome', as: 'welcome'
  get 'home' => 'pages#home', as: 'home'
  get 'apps/hire/:id' => 'applications#hire', as: 'applications_hire'
  get 'application' => 'applications#new', as: '/application'

  resources :sports_events
  resources :events
  resources :awards
  resources :settings
  resources :news_posts
  resources :podcasts
  resources :slots
  resources :positions
  resources :managers

  resources :applications do
    get :autocomplete_genre_name, on: :collection
    collection do
      put 'admin'
    end
  end

  resources :apps, controller: 'applications' do
    get :autocomplete_genre_name, on: :collection
    collection do
      put 'admin'
    end
  end

  resources :people do
    collection do
      get 'search'
      put 'admin'
      post :reset_password
      post :send_password_reset
      post :archive
      post :restore
    end
  end

  resources :shows do
    collection do
      get 'search'
      get :autocomplete_genre_name
      put 'admin'
    end
  end

  if Rails.env == 'production'
    devise_for :people, controllers: {:registrations => 'registrations' }, path: '/', path_names: { sign_in: 'login', sign_out: 'logout' }
  else
    devise_for :people, path: '/', path_names: { sign_in: 'login', sign_out: 'logout' }
  end
end
