Mentorme::Application.routes.draw do

  root :to => "static_pages#home"

  resources :meetings do
    member do
      get 'show'
    end
  end
  
  get "videotest" => "meetings#show"
  get '/auth/:provider/callback' => 'sessions#create'

  get "user" => "users#show", :as => "profile"
  get "user/edit" => "users#edit"
  put "user" => "users#update"

end
