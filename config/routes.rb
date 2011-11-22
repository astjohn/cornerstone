Cornerstone::Engine.routes.draw do

  resources :discussions, :except => [:show] do
    resources :posts, :only => [:create, :edit, :update, :destroy]
  end

  # Custom routes to handle show for discussions and discussion categories
  get "/discussions/:category/:id" => "discussions#show", :as => "category_discussion"
  get "/discussions/:category" => "discussions#category", :as => "discussions_category"

  # Custom routes for knowledge base
  get "/knowledge/:category/:id" => "knowledgebase#show", :as => "category_article"
  get "/knowledge/:category" => "knowledgebase#category", :as => "articles_category"
  get "/knowledge/" => "knowledgebase#index", :as => "knowledge_base"

  root :to => "help#index"

  namespace :admin do
    root :to => "admin#dashboard"
    resources :categories, :except => :show
    resources :articles
    resources :discussions, :only => [:edit, :update]
  end

end
