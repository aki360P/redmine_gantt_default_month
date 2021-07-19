#require_dependency 'gantt_helper'

module RgdmGanttHelperPatch
  module GanttPatch
    
    
    def initialize(options={})
      super
      puts options
      aaa = options["project_id"]
      puts aaa
      @project = Project.find_by(identifier: aaa)
      if @project.module_enabled?(:redmine_gantt_default_month)
        #@date_from = Date.civil(2021,1.1)
        rgdm_setting = RgdmSetting.find_or_create(@project.id)
        aab = rgdm_setting.customfield_id
        puts aab
        d =  CustomValue.where(customized_type: "Project", custom_field_id: aab).first.value
        #@date_from = Date.strptime(d, '%Y-%m-%d').strftime('%Y-%m-01').to_s
        #@date_from = Date.civil(d.year,d.month,1)
        darray = d.split("-")
        @date_from = Date.new(darray[0].to_i,darray[1].to_i,1)
        puts @date_from
      end
    end
  end
end

Redmine::Helpers::Gantt.prepend RgdmGanttHelperPatch::GanttPatch

