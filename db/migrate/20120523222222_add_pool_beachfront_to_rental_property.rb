class AddPoolBeachfrontToRentalProperty < ActiveRecord::Migration
  def up
    hange_column :rental_property_options, :my_column, :datetime
  end
  
  def down
    remove_column :rental_property_options, :pool
    remove_column :rental_property_options, :beachfront
  end
end
                                      