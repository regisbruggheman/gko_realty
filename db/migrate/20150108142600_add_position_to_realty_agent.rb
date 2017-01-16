class AddPositionToRealtyAgent < ActiveRecord::Migration
  def change
    add_column :realty_agents, :position, :integer, :default => 1
  end
end