Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :v1 do
    resources :students, except: %i[new edit] do
      resources :grades, except: %i[new edit]
    end
    resources :parents, except: %i[new edit]
    post '/parents/:id/add-student/:student_id', to: 'parents#add_student'
    get '/parents/:id/students', to: 'parents#students'
  end
end
