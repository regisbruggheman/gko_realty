class UpdateRealtyAgentPosition < ActiveRecord::Migration
  def change
    Site.all.each do |site|
      site.realty_agents.each_with_index do |a, index|
        a.update_attribute('position', index + 1)
      end
    end
  end
end