Rails.application.routes.draw do
  devise_for :auth_users
  root 'lab_reports#index'

  resources :lab_reports

  get '/LabReports/:id/mark', to: 'lab_reports#mark', as: 'mark_lab_report'
  post '/LabReports/:id/mark', to: 'lab_reports#grade'
end
