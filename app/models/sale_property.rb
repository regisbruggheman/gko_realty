class SaleProperty < Content
  
  acts_as_indexed :fields => [:title]
    
  #----- Associations --------------------------------------------------------------
  
  has_one :meta,
    :class_name => "SalePropertyOption", 
    :foreign_key => :property_id, 
    :dependent => :destroy
  accepts_nested_attributes_for :meta
  
  has_many :content_options, :as => :owner, :dependent => :destroy
  accepts_nested_attributes_for :content_options, :reject_if => lambda { |ov| ov[:option_value_id].blank? }
  has_many :option_values, :through => :content_options
  has_many :option_types, :through => :content_options

  has_many :sale_property_assignments, :foreign_key => "property_id", :dependent => :destroy

  attr_accessible :meta_attributes, :content_options_attributes
  
  has_option :show_price_in_frontend, :default => true, :type => :boolean
   
  #----- Delegate ---------------------------------------------------------------
  
  delegate :acreage, :area, :city, :building_size, :show_in_homepage, 
           :bathroom_count, :bedroom_count, :currency, :lat_long, :price, 
           :badge, :realty_agent, :exchange_price, :year_built, :video_url, :to => :meta, :allow_nil => true
  
  #----- Class methods -----------------------------------------------------------
  class << self

    def by_title()
      with_translations().order("content_translations.title ASC")
    end
    
    def by_price(currency="eur")
      joins(:meta).order("sale_property_options.price ASC")
    end
    
    def with_bedroom_count(count)  
      joins(:meta).where("sale_property_options.bedroom_count >= ?", count.to_i)
    end
    def in_area(area_id)  
      joins(:meta).where(:sale_property_options => {:area_id => area_id})
    end
    def in_city(city_id)  
      joins(:meta).where(:sale_property_options => {:city_id => city_id})
    end
    def rates_between(from, to, currency="eur")
      joins(:meta).where("sale_property_options.price IS NOT NULL AND sale_property_options.price IS NOT NULL AND sale_property_options.price >= ? AND sale_property_options.price <= ?", from, to)
    end
    def rates_less_than(max_rates, currency="eur")
      joins(:meta).where("sale_property_options.price IS NOT NULL AND sale_property_options.price <= ?", max_rates)
    end
    def rates_more_than(min_rates, currency="eur")
      joins(:meta).where("sale_property_options.price IS NOT NULL AND sale_property_options.price >= ?", min_rates)
    end
    
    def in_homepage
      joins(:meta).where(:sale_property_options => {:show_in_homepage => true})
    end
    
  end
  
  def available_option_types
    o = OptionType.with_classname(self.class.name)
    selected_option_types = []
    self.option_types.each do |option|
      selected_option_types << option
    end
    o.delete_if {|ot| selected_option_types.include? ot}
  end
end
