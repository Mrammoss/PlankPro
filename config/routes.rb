Rails.application.routes.draw do
  devise_for :users
  get "home/index"
  root to: "home#index"

  resources :projects do
    resources :cut_yields, only: [:create] do
      collection do
        post :calculate
      end
    end

    resources :miter_frames, only: [:create] do
      collection do
        post :calculate
      end
    end
  end

  resources :miter_frames
  resources :cut_yields
  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:
  # get("/your_first_screen", { :controller => "pages", :action => "first" })
end
