class RgdmSetting < ActiveRecord::Base
  include Redmine::SafeAttributes
  belongs_to :project

  validates_uniqueness_of :project_id
  validates :project_id, presence: true
  

  def self.find_or_create(project_id)
    rgdm_setting = RgdmSetting.where(['project_id = ?', project_id]).first
    puts ' ====================== '
    
    unless rgdm_setting.present?
      rgdm_setting = RgdmSetting.new()
      rgdm_setting.attributes = { project_id: project_id }
      
      # Set default
      rgdm_setting.attributes = { option: 0 }
      rgdm_setting.attributes = { default_month: '2000-01-01' }
            
      rgdm_setting.save!
    end
    rgdm_setting
  end

end
