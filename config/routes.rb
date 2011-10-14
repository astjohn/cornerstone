Cornerstone::Engine.routes.draw do



  resources :discussions, :except => [:show] do
    resources :posts, :only => [:create, :edit, :update, :destroy]
  end

  # Custom routes to handle show for discussions and discussion categories
  get "/discussions/:category/:id" => "discussions#show", :as => "category_discussion"
  get "/discussions/:category" => "discussions#category", :as => "discussions_category"


  root :to => "help#index"

  namespace :admin do
    root :to => "admin#dashboard"
    resources :categories, :except => :show
    resources :articles
    resources :discussions, :only => [:edit, :update]
  end

end

