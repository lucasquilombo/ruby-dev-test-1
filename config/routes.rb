Rails.application.routes.draw do
    root to: "diretorios#index"

    resources :diretorios, only: [:index, :create, :update, :destroy] do
        resources :arquivos, only: [:create, :destroy]
    end
end
