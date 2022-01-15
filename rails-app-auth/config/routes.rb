Rails.application.routes.draw do
  root 'lab_reports#index'

  resources :lab_reports
  resources :users

  get '/LabReports/:id/mark', to: 'lab_reports#mark', as: 'mark_lab_report'
  post '/LabReports/:id/mark', to: 'lab_reports#grade'
  get '/Users/:id', to: 'users#show'
end
