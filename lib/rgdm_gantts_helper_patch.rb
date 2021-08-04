#require_dependency 'gantt_helper'

module RgdmGanttHelperPatch
  module GanttPatch
    
    
    def initialize(options={})
      super

      #load global setting
      setting_rgdm = Setting.plugin_redmine_gantt_default_month

      #option0: global setting "none"
      return if setting_rgdm['rgdm_option'] == '0'


      #load project_id to view
      project_id = options["project_id"]
      @project = Project.find_by(identifier: project_id)

      #global view
      if @project.nil? then
        #option1: customfield in specific project -> nothing
        if setting_rgdm['rgdm_option'] == '1' && setting_rgdm['rgdm_customfield_id'] != '0' then
          return
        
        #option2: default month
        elsif setting_rgdm['rgdm_option'] == '2' && setting_rgdm['rgdm_customfield_id'] != '0' then
          d =  setting_rgdm['rgdm_default_month']
          darray = d.split("-")
          @date_from = Date.new(darray[0].to_i,darray[1].to_i,1)

        end

      #project is specified
      else
        #load project setting
        setting = RgdmSetting.find_or_create(@project.id)

        #project setting is not specified
        if setting.option == 0 then

          #option1: customfield in this project
          if setting_rgdm['rgdm_option'] == '1' && setting_rgdm['rgdm_customfield_id'] != '0' then
            d =  CustomValue.where(customized_type: "Project", custom_field_id: setting_rgdm['rgdm_customfield_id']).first.value

            #ToDO : error_check

            darray = d.split("-")
            @date_from = Date.new(darray[0].to_i,darray[1].to_i,1)
        
          #option2: default month
          elsif setting_rgdm['rgdm_option'] == '2' then           
            d =  setting_rgdm['rgdm_default_month']
            darray = d.split("-")
            @date_from = Date.new(darray[0].to_i,darray[1].to_i,1)

          end

        #project setting is specified
        elsif setting.option == 2 then 
            d =  setting.default_month
            @date_from = Date.new(d.year,d.month,1)

        end
      end
    end
    #@date_from is ganttchart start_date

  end
end

Redmine::Helpers::Gantt.prepend RgdmGanttHelperPatch::GanttPatch

