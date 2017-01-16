class Admin::SalePropertySelectionListsController < Admin::SectionsController
    before_filter :load_sale_properties, :only => [:edit, :update, :new, :create]
    #before_filter :load_parent_page, :only => :new

    def new
        @parent_page = @site.sections.named("selections")
        if @parent_page
            resource.parent_id = @parent_page.id
        end
    end


    protected
  
    def load_sale_properties
        @sale_properties = current_site.sale_properties.by_title
    end

    
end