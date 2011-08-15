Cornerstone::Engine.routes.draw do

  resources :discussions, :except => :show
  get "/discussions/:category" => "discussions#category", :as => "discussions_category"
  get "/discussions/:category/:id" => "discussions#show", :as => "discussion"

  resources :categories

  root :to => "help#index"

end

