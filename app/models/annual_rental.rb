class AnnualRental < Content
    acts_as_indexed :fields => [:title]
    
    has_one :meta,
      :class_name => "AnnualRentalOption", 
      :foreign_key => :property_id, 
      :dependent => :destroy
    accepts_nested_attributes_for :meta

    attr_accessible :meta_attributes
    
    delegate :area, :city, :show_in_homepage, :bedroom_count, :lat_long, :price, :realty_agent, :room_count, :bathroom_count, :garden, :accept_roommate, :furnished, :deposit, :acreage, :to => :meta, :allow_nil => true
    
    def self.with_bedroom_count(count)  
      joins(:meta).where("annual_rental_options.bedroom_count >= ?", count.to_i).order("annual_rental_options.bedroom_count ASC")
    end
    def self.in_area(area_id)  
      joins(:meta).where(:annual_rental_options => {:area_id => area_id})
    end
end