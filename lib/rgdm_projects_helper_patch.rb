require 'projects_helper'

module RgdmProjectsHelperPatch
    extend ActiveSupport::Concern

    def project_settings_tabs
      
      #load global setting
      @setting_rgdm = Setting.plugin_redmine_gantt_default_month

      #append tabs - Project Enable Module will not show.
      #Enable with global setting
      tabs = super
      if @setting_rgdm['rgdm_option'] == '0' then
        return tabs
      else
        tabs.tap { |t| t << append_rgdm_tab }.compact
      end
      
    end

    def append_rgdm_tab
      @rgdm_setting = RgdmSetting.find_or_create(@project.id)
      action = { name: 'rgdm_settings',
                 controller: 'rgdm_settings',
                 action: :edit,
                 partial: 'rgdm_settings/show', label: :label_rgdm }
      return nil unless User.current.allowed_to?(action, @project)

      action
    end

end

ProjectsController.helper(RgdmProjectsHelperPatch)
