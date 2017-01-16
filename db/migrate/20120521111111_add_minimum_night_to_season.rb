class AddMinimumNightToSeason < ActiveRecord::Migration
  def up
    add_column :rental_property_seasons, :minimum_night, :integer, :default => 1
  end
  
  def down
    remove_column :rental_property_seasons, :minimum_night
  end
end
                                      