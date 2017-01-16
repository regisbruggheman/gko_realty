class Admin::SalePropertiesController < Admin::ContentsController
  belongs_to :site
  belongs_to :sale_property_list
  before_filter :init_associations, :only => [:new, :edit]

  def toggle_in_homepage
    @sale_property = SaleProperty.find_by_id(params[:id])
    in_homepage = @sale_property.show_in_homepage
    @sale_property.meta.update_attribute(:show_in_homepage, !in_homepage)
    
    #redirect_to :back
    if !in_homepage
      flash[:notice] = t(:'flash.sale_property.add_in_homepage')
    else
      flash[:notice] = t(:'flash.sale_property.delete_from_homepage')
    end
    respond_with(resources)
  end
  
  def init_associations
    resource.build_meta if resource.meta.nil?
  end
end