class CreateSettingTable < ActiveRecord::Migration[4.2]
  #for redmine 3x,  class CreateSettingTable < ActiveRecord::Migration
  #for redmine 4x,  class CreateSettingTable < ActiveRecord::Migration[4.2]
  
  def self.up
    create_table :rgdm_settings do |t|
      t.column :project_id, :integer
      t.column :option, :integer
      t.column :default_month, :datetime
    end
  end

  def self.down
    drop_table :rgdm_settings
  end
end
