Site.class_eval do
  has_many :rental_property_lists
  has_many :rental_properties, :through => :rental_property_lists
  has_many :sale_property_lists
  has_many :sale_properties, :through => :sale_property_lists
  has_many :annual_rental_lists
  has_many :annual_rentals, :through => :annual_rental_lists
  has_many :season_prototypes, :dependent => :destroy
  has_many :option_types, :dependent => :destroy
  has_many :realty_agents, :order => "position", :dependent => :destroy
  has_many :cities, :dependent => :destroy
  has_many :areas, :through => :cities
  has_many :rental_property_inquiries, :dependent => :destroy
  has_many :sale_property_inquiries, :dependent => :destroy
  has_many :annual_rental_inquiries, :dependent => :destroy
  has_many :sale_property_selection_lists
  has_many :rental_property_selection_lists
  has_many :statutes, :dependent => :destroy
  
  
  preference :use_statutes, :boolean, :default => false
  preference :use_realty_agent, :boolean, :default => false
  preference :use_realty_beachfront, :boolean, :default => true
  preference :use_realty_pool, :boolean, :default => true
  preference :realty_agent_public, :boolean, :default => false 
  preference :realty_agent_image_size, :string, :default => '80x'
  
  attr_accessible :preferred_use_realty_agent,  
    :preferred_realty_agent_public, 
    :preferred_realty_agent_image_size,
    :preferred_use_statutes,
    :preferred_use_realty_pool,
    :preferred_use_realty_beachfront
end
