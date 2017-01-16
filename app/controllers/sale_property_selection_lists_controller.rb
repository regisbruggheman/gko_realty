class SalePropertySelectionListsController < PagesController

    before_filter :load_sale_properties, :only => :show
    
    protected

    def template?
        "sale_property_selection_lists/show"
    end

    def load_sale_properties
        @sale_properties = resource.sale_properties
    end
end