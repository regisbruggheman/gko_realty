class RentalPropertyRate < ActiveRecord::Base
  #----- Associations ------------------------------------------------------------
  belongs_to :season, 
    :class_name => "RentalPropertySeason", 
    :foreign_key => :season_id,
    :touch => true
    
  attr_accessible :eur_price, :usd_price, :bedroom_count, :season_id
  
  #----- Validations ------------------------------------------------------------
  # validates :season_id, :presence => true
end
