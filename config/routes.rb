Rails.application.routes.draw do

  namespace :admin do
    
    resources :sites do
      
      resources :statutes
      
      resources :cities do
        resources :areas
      end
      resources :option_types
      resources :realty_agents
      
      resources :season_prototypes do
        collection do
          get :availables
        end
        member do
          post :select
        end
      end

      resources :rental_property_selection_lists

      resources :sale_property_selection_lists

      resources :annual_rental_lists do
        resources :annual_rentals do
          collection do
            get :selected
          end
          member do
            get :toggle_in_homepage
          end
        end
      end
      resources :rental_property_lists do
        resources :rental_properties do
          collection do
            get :selected
          end
          member do
            get :toggle_in_homepage
          end
        end
      end
      resources :rental_properties do
        resources :rental_property_seasons do
          collection do
            post :create_multiple, :as => :create_multiple_seasons
          end
        end
      end
      resources :sale_property_lists do
        resources :sale_properties do
          collection do
            get :selected
          end
          member do
            get :toggle_in_homepage
          end
        end
      end
    end
  end

  resources :rental_property_inquiries, :only => [:create]
  resources :sale_property_inquiries, :only => [:create]
  resources :annual_rental_inquiries, :only => [:create]
  

  get "sale_property_selection_lists/:id", :to => 'sale_property_selection_lists#show', :as => :sale_property_selection_list
  get "rental_property_selection_lists/:id", :to => 'rental_property_selection_lists#show', :as => :rental_property_selection_list

  get 'annual_rental_lists/:annual_rental_list_id/categories/:category_id', 
    :to => 'annual_rentals#index', 
    :as => :annual_rental_list_category
  get 'annual_rental_lists/:annual_rental_list_id/tags/:sticker_id', 
    :to => 'annual_rentals#index', 
    :as => :annual_rental_list_sticker
  get 'annual_rental_lists/:annual_rental_list_id', 
    :to => 'annual_rentals#index', 
    :as => :annual_rental_list
  get 'sale_property_lists/:sale_property_list_id/categories/:category_id', 
    :to => 'sale_properties#index', 
    :as => :sale_property_list_category
  get 'sale_property_lists/:sale_property_list_id/tags/:sticker_id', 
    :to => 'sale_properties#index', 
    :as => :sale_property_list_sticker
  get 'rental_property_lists/:rental_property_list_id/categories/:category_id', 
    :to => 'rental_properties#index', 
    :as => :rental_property_list_category
  get 'rental_property_lists/:rental_property_list_id/tags/:sticker_id', 
    :to => 'rental_properties#index', 
    :as => :rental_property_list_sticker
  get 'sale_property_lists/:sale_property_list_id', 
    :to => 'sale_properties#index', 
    :as => :sale_property_list
  get 'rental_property_lists/:rental_property_list_id/promotions',
    :to => 'rental_properties#promotions', 
    :as => :rental_property_list_promotions
  get 'rental_property_lists/:rental_property_list_id', 
    :to => 'rental_properties#index', 
    :as => :rental_property_list

      
  match 'annual_rental_lists/:annual_rental_list_id/:permalink', 
    :to => "annual_rentals#show", 
    :as => :annual_rental_list_annual_rental  
  match 'sale_property_lists/:sale_property_list_id/:permalink', 
    :to => "sale_properties#show", 
    :as => :sale_property_list_sale_property
  match 'rental_property_lists/:rental_property_list_id/:permalink', 
    :to => "rental_properties#show", 
    :as => :rental_property_list_rental_property
end