Rails.application.routes.draw do

  resources :report_lists do
    get :reportable, on: :collection
    resources :table_lists do
      get :row, on: :member
    end
  end

  resources :combines do
    get :table_lists, on: :member
  end

end
