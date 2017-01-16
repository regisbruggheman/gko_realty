class AddCurrencyToSaleProperty < ActiveRecord::Migration
  def change
    unless column_exists?(:sale_property_options, :currency)
      add_column :sale_property_options, :currency, :string, :limit => 1, :default => "€"
    end
  end
end
                                      