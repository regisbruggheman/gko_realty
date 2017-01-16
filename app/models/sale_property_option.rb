class SalePropertyOption < ActiveRecord::Base
  
  translates :badge
  
  class Translation
    attr_accessible :locale
  end
  belongs_to :statute
  belongs_to :property, 
    :class_name => "SaleProperty",
    :foreign_key => :property_id,
    :touch => true
  belongs_to :area
  belongs_to :city
  belongs_to :realty_agent
  
  attr_accessible( 
    :notes, 
    :bedroom_count, 
    :room_count, 
    :acreage, 
    :code, 
    :price, 
    :lat_long, 
    :postcode, 
    :city_id, 
    :province_state, 
    :country_id, 
    :area_id, 
    :property_id, 
    :show_in_homepage, 
    :year_built, 
    :building_size, 
    :bathroom_count, 
    :realty_agent_id, 
    :currency, 
    :badge, 
    :exchange_price,
    :video_url, :statute_id, :statute)
  
end