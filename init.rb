require 'redmine'
require 'rgdm_projects_helper_patch'
require 'rgdm_gantts_helper_patch'

Redmine::Plugin.register :redmine_gantt_default_month do
  name 'Redmine gantt default month plugin'
  author 'Akinori Iwasaki'
  description 'Preset default month to ganttchart'
  version '1.0.0'
  url 'https://github.com/aki360P/redmine_gantt_default_month'
  

  permission :rgdm_setting, :rgdm_settings => [:edit]

  # setting
  settings  partial: 'rgdm_global_settings/show',
            default: {
              'rgdm_option' => '0',
              'rgdm_customfield_id' => '0',
              'rgdm_default_month' => '0'
            }
end