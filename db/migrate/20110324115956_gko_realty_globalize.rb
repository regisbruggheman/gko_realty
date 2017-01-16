class GkoRealtyGlobalize < ActiveRecord::Migration
  def up
    # Copy migrations :AddPromoToRentalProperty" else Globalize send error 
    unless column_exists?(:rental_property_options, :promo_text)
      add_column :rental_property_options, :promo_text, :text
      add_column :rental_property_option_translations, :promo_text, :text
    end
    
    unless table_exists?(:rental_property_season_translations)
      RentalPropertySeason.create_translation_table!({
        :title => :string
      }, {:migrate_data => true})
      RentalPropertyOption.create_translation_table!({
        :children_policy => :text, :description => :text
      }, {:migrate_data => true})
    end
  end
  def down
    RentalPropertySeason.drop_translation_table! :migrate_data => true
    RentalPropertyOption.drop_translation_table! :migrate_data => true
  end
end
 