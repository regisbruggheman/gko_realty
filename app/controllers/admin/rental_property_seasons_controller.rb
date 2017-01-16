class Admin::RentalPropertySeasonSweeper < Gko::Sweeper
  observe RentalPropertySeason
  def after_create(season)
    expire_season_cache(season)
  end
  def after_update(season)
    expire_season_cache(season)
  end
  def after_destroy(season)
    expire_season_cache(season)
  end
  protected
  def expire_season_cache(season)
    expire_content_cache(season.property)
  end  
end
class Admin::RentalPropertySeasonsController < Admin::ResourcesController
  belongs_to :site
  belongs_to :rental_property
  respond_to :html, :js
  cache_sweeper ::Admin::RentalPropertySeasonSweeper, :only => [:create,:update,:destroy]
  def create
    create! do |success, failure|
      success.any { render :action => :create and return }
      failure.any { render :action => :new and return }
    end
  end

  def update
    update! { render :action => :update and return }
  end
end