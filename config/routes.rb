SampleApp::Application.routes.draw do
    root :to => 'pages#home'
    match '/contact', :to => 'pages#contact'
    match '/help', :to => 'pages#help'
    match '/about', :to => 'pages#about'
    
end
