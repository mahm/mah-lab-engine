BlogMahLabCom::Application.routes.draw do
  # Index page
  root :to => 'blog#index'
  match 'index(.:format)' => 'blog#index'

  # Archive page
  match '/:year',             :to => 'blog#archive'
  match '/:year/:month',      :to => 'blog#archive'
  match '/:year/:month/:day', :to => 'blog#archive'

  # Entry page
  match '/:year/:month/:day/:slug', :to => 'blog#entry'
end
