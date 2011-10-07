Cornerstone::Engine.routes.draw do

  resources :articles

  resources :discussions, :except => :show do
    resources :posts, :only => [:create, :update]
  end
  get "/discussions/:category" => "discussions#category", :as => "discussions_category"
  get "/discussions/:category/:id" => "discussions#show", :as => "discussion"

  resources :categories

  root :to => "help#index"

end

