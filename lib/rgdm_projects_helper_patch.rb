require 'projects_helper'

module RgdmSettings
  module ProjectsHelperPatch
    extend ActiveSupport::Concern

    def project_settings_tabs
      tabs = super
      return tabs unless @project.module_enabled?(:redmine_gantt_default_month)

      tabs.tap { |t| t << append_rgdm_tab }.compact
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
end

ProjectsController.helper(RgdmSettings::ProjectsHelperPatch)
