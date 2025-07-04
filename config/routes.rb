Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :todo_lists, only: %i[index show create update destroy], path: :todolists do
        resources :todo_items, only: %i[index show create update destroy], path: :items do
          collection do
            patch :bulk_update
          end
        end
      end
    end
  end

  resources :todo_lists, path: :todolists do
    resources :todo_items, path: :items do
      patch :complete, on: :member
      patch :complete_all, on: :collection
    end
  end
end
