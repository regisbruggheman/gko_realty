class AddStatutesToSaleProperties < ActiveRecord::Migration
  def change
    add_column :sale_property_options, :statute_id, :integer
    add_column :annual_rental_options, :statute_id, :integer
  end
end