Cornerstone::Engine.routes.draw do

  resources :articles


  resources :discussions, :except => [:show] do
    resources :posts, :only => [:create, :edit, :update, :destroy]
  end

  # Custom routes to handle show for discussions and discussion categories
  get "/discussions/:category/:id" => "discussions#show", :as => "category_discussion"
#  get "/discussions/:category/:id/edit" => "discussions#edit", :as => "edit_category_discussion"
  get "/discussions/:category" => "discussions#category", :as => "discussions_category"

  resources :categories, :except => :show

  root :to => "help#index"

end

