Mentorme::Application.routes.draw do

  root :to => "static_pages#home"

  resources :meetings do
    member do
      get 'show'
    end
  end
  
  get "videotest" => "meetings#show"
  get '/auth/:provider/callback' => 'sessions#create'

end
