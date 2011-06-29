Musociety::Application.routes.draw do
  get "home/index"

  resources :roles
  resources :user_profiles do
    resources :invites do
      member do
        get :add_network_invitation
      end
    end

    collection do
      post 'invite_a_friend'
      get 'friends'
      get 'make_friends'
    end
  end
  get "registrations/create"

  devise_for :users, :path_names => { :sign_in => 'signin', :sign_out => 'signout', :sign_up => 'register' }, :controllers => { :registrations => "registrations" }
  devise_scope :user do match 'users/signup/:invite_token' => 'registrations#new', :as => 'invite_signup_path' end
  devise_scope :user do match 'users/members' => 'registrations#members', :as => 'members_path' end
  
  resources :audio_attachments
  match 'settings' => 'settings#index', :as => 'settings'
  match "invitation/:code" => 'invites#show', :as => 'invitation_link'
  match 'invitation/accept/:code' => 'invites#accept', :as => 'accept_invitation'
  match 'invitation/decline/:code' => 'invites#decline', :as => 'decline_invitation'
  
  namespace :xml do
    match 'location_search.xml' => 'LocationSearch#index', :format => :xml
    match 'address_search.xml'  => 'AddressSearch#index' , :format => :xml
  end


  namespace :admin do
    resources :members do
      member do
        get :remove
      end
    end
  end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"
  root :to => "home#index"
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
