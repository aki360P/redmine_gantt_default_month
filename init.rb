require 'redmine'
require 'rgdm_projects_helper_patch'
require 'rgdm_gantts_helper_patch'

Redmine::Plugin.register :redmine_gantt_default_month do
  name 'Redmine gantt default month plugin'
  author 'Akinori Iwasaki'
  description 'Preset gantt chart default month from'
  version '0.1.0'
  url 'https://github.com/aki360P/redmine_gantt_default_month_plugin'
  
  project_module :redmine_gantt_default_month do
    permission :rgdm_setting, :rgdm_settings => [:edit]
  end
  
  
  # add tab - project module
  menu :project_menu, :rgdm, {:controller => 'rgdm', :action => 'index' }, :caption => :label_rgdm, :param => :project_id
  
end