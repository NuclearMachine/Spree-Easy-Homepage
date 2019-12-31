Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :home_sections do
      collection do
        post :update_positions
      end
    end
  end
end
