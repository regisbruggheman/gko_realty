class AddRealtyAgentToAnnualRentals < ActiveRecord::Migration
  def change
    add_column :annual_rental_options, :realty_agent_id, :integer
    add_index :annual_rental_options, :realty_agent_id
  end
end