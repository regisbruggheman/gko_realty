class AddYearBuiltToSaleProperty < ActiveRecord::Migration
  def change
    unless column_exists?(:sale_property_options, :year_built)
      add_column :sale_property_options, :year_built, :integer  
      add_column :sale_property_options, :building_size, :integer
    end 
  end
end
 