BlogMahLabCom::Application.routes.draw do
  # Index page
  root :to => 'blog#index'
  match 'index(.:format)' => 'blog#index'

  # Archive page
  match '/:year',             :to => 'blog#archive', :year => /\d{4}/
  match '/:year/:month',      :to => 'blog#archive', :year => /\d{4}/, :momth => /\d{2}/
  match '/:year/:month/:day', :to => 'blog#archive', :year => /\d{4}/, :momth => /\d{2}/, :day => /\d{2}/

  # Backnumber page
  match '/backnumber', :to => 'blog#backnumber'

  # Entry page
  match '/:year/:month/:day/:slug', :to => 'blog#entry', :year => /\d{4}/, :momth => /\d{2}/, :day => /\d{2}/
end
