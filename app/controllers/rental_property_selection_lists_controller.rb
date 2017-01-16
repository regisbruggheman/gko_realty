class RentalPropertySelectionListsController < PagesController

  before_filter :load_rental_properties, :only => :show
    
  protected

  def template?
    "rental_property_selection_lists/show"
  end

  def load_rental_properties
    @rental_properties = resource.rental_properties
  end
  
end