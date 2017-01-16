class AnnualRentalOption < ActiveRecord::Base
  belongs_to :statute
  belongs_to :property, 
    :class_name => "AnnualRental",
    :foreign_key => :property_id,
    :touch => true
  belongs_to :area
  belongs_to :city
  belongs_to :realty_agent
  
  attr_accessible :notes,:bedroom_count,:room_count,:code,:price,:lat_long,:postcode,:city_id,:province_state,:country_id,:area_id, :property_id, :show_in_homepage, :room_count, :bathroom_count, :garden, :accept_roommate, :furnished, :deposit, :acreage, :statute_id, :statute
  
end