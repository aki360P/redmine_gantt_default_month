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

      #When user apply ganttchart setting
      #quit plugin
      return if options["month"].present?

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
          @month_from = darray[1].to_i

        end

      #project is specified
      else
        #load project setting
        setting = RgdmSetting.find_or_create(@project.id)

        #project setting is not specified
        if setting.option == 0 then

          #option1: customfield in this project
          if setting_rgdm['rgdm_option'] == '1' && setting_rgdm['rgdm_customfield_id'] != '0' then
            d =  CustomValue.where(customized_id: @project.id, custom_field_id: setting_rgdm['rgdm_customfield_id'])
            if d.present? then
              d = d.first.value

              darray = d.split("-")
              @date_from = Date.new(darray[0].to_i,darray[1].to_i,1)
              @month_from = darray[1].to_i
            end
        
          #option2: default month
          elsif setting_rgdm['rgdm_option'] == '2' then           
            d =  setting_rgdm['rgdm_default_month']
            darray = d.split("-")
            @date_from = Date.new(darray[0].to_i,darray[1].to_i,1)
            @month_from = darray[1].to_i

          end

        #project setting is specified
        elsif setting.option == 2 then 
            d =  setting.default_month
            @date_from = Date.new(d.year,d.month,1)
            @month_from = d.month

        end
      end
    end
    #@date_from is ganttchart start_date. See this file [redmine root]\lib\redmine\helpers\gantt.rb
    #@month_from is ganttchart start_month and displayed on the header. See this file [redmine root]\lib\redmine\helpers\gantt.rb

  end
end

Redmine::Helpers::Gantt.prepend RgdmGanttHelperPatch::GanttPatch

