SampleApp::Application.routes.draw do
  get "users/new"

    root :to => 'pages#home'
    match '/contact', :to => 'pages#contact'
    match '/help', :to => 'pages#help'
    match '/about', :to => 'pages#about'
    match '/signup', :to => 'users#new'
    
end
