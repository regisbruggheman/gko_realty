class AddBathroomCountToSaleProperty < ActiveRecord::Migration
  def change
    unless column_exists?(:sale_property_options, :bathroom_count)
      add_column :sale_property_options, :bathroom_count, :integer
    end
  end
end
                                      