class RgdmSettingsController < ApplicationController
  unloadable
  before_action :require_login
  before_action :find_user, :find_project, :authorize

  def initialize
    super()
  end

  
  def edit
    unless params[:settings].nil?
      rgdm_setting = RgdmSetting.find_or_create(@project.id)
      
      rgdm_setting.update(rgdm_setting_params)
      rgdm_setting.save
      flash[:notice] = l(:notice_successful_update)
      redirect_to controller: 'projects',
                  action: 'settings', id: @project, tab: 'rgdm_settings'
    end
    
  end
  
  def show
    
  end
  
  

  private

  def find_user
    @user = User.current
  end

  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
  
  def rgdm_setting_params
    params.require(:settings).permit('project_id','customfield_id')
  end
end
