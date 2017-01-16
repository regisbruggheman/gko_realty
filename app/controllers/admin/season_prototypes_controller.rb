class Admin::SeasonPrototypesController < Admin::ResourcesController
  belongs_to :site
  custom_actions :collection => [:availables]
  respond_to :html, :js
  before_filter :load_rental_property, :only => :availables
  
  def select
    @season_prototype ||= SeasonPrototype.find(params[:id])
    @rental_property = RentalProperty.find(params[:rental_property_id])
    @rental_property_season = @rental_property.rental_property_seasons.create({
      :title => @season_prototype.title,
      :start_date => @season_prototype.start_date,
      :end_date => @season_prototype.end_date
    }) 
  end
  
  protected
  
  def load_rental_property
    @rental_property = RentalProperty.find(params[:rental_property_id])
  end
end