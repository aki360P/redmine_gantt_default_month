Rails.application.routes.draw do
  match 'projects/:project_id/settings/rgdm_setting/:action', :controller => 'rgdm_settings', :via => [:get, :post, :patch, :put]
end