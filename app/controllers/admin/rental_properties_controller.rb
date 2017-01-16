class Admin::RentalPropertiesController < Admin::ContentsController
  nested_belongs_to :site, :rental_property_list
  before_filter :init_associations, :only => [:new, :edit]

  def toggle_in_homepage
    @rental_property = RentalProperty.find_by_id(params[:id])
    in_homepage = @rental_property.show_in_homepage
    @rental_property.meta.update_attribute(:show_in_homepage, !in_homepage)

    if !in_homepage
      flash[:notice] = t(:'flash.rental_property.add_in_homepage')
    else
      flash[:notice] = t(:'flash.rental_property.delete_from_homepage')
    end
    respond_with(resources)
  end

  def init_associations
    resource.build_meta if resource.meta.nil?
  end

end
