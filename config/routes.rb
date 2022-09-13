Rails.application.routes.draw do
  #match 'projects/:project_id/settings/rgdm_setting/:action', :controller => 'rgdm_settings', :via => [:get, :post, :patch, :put]

  resources :projects do
    patch '/settings/rgdm_setting/rgdm_setting', :controller => 'rgdm_settings', action: :edit
  end
end