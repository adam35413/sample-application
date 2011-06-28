SampleApp::Application.routes.draw do

    resources :users
    resources :sessions, :only => [:new, :create, :destroy]
    resources :microposts, :only => [:create, :destroy]
    

    # Sessions
    match '/signin',  :to => 'sessions#new'
    match '/signout', :to => 'sessions#destroy'

    # Pages
    match '/contact', :to => 'pages#contact'
    match '/help', :to => 'pages#help'
    match '/about', :to => 'pages#about'

    # Users
    match '/signup', :to => 'users#new'
    
    root :to => 'pages#home'
end
