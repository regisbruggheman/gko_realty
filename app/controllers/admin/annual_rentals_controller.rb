class Admin::AnnualRentalsController < Admin::ContentsController
  nested_belongs_to :site, :annual_rental_list
  before_filter :init_associations, :only => [:new, :edit]

  def toggle_in_homepage
    @annual_rental = AnnualRental.find_by_id(params[:id])
    in_homepage = @annual_rental.show_in_homepage
    @annual_rental.meta.update_attribute(:show_in_homepage, !in_homepage)

    #redirect_to :back
    if !in_homepage
      flash[:notice] = t(:'flash.annual_rental.add_in_homepage')
    else
      flash[:notice] = t(:'flash.annual_rental.delete_from_homepage')
    end
    respond_with(resources)
  end

  def init_associations
    resource.build_meta if resource.meta.nil?
  end
end
