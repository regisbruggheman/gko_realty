class AddExchangePriceToSalePropertiesOption < ActiveRecord::Migration
  def up
    add_column :sale_property_options, :exchange_price, :integer
  end
  
  def down
    remove_column :sale_property_options, :exchange_price
  end
end
                                      