require 'redmine'
require File.expand_path('../lib/rgdm_projects_helper_patch', __FILE__)
require File.expand_path('../lib/rgdm_gantts_helper_patch', __FILE__)

Redmine::Plugin.register :redmine_gantt_default_month do
  name 'Redmine gantt default month plugin'
  author 'Akinori Iwasaki'
  description 'Preset default month to ganttchart'
  version '1.1.0'
  url 'https://github.com/aki360P/redmine_gantt_default_month'
  
  # this plugin permission is included in existing "project" module
    permission :rgdm_setting, :rgdm_settings => [:edit]

  # setting
  settings  partial: 'rgdm_global_settings/show',
            default: {
              'rgdm_option' => '0',
              'rgdm_customfield_id' => '0',
              'rgdm_default_month' => '0'
            }
end