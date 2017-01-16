class SalePropertyList < Section  
  include Extensions::Models::IsList
  has_many :sale_properties, :foreign_key => 'section_id', :dependent => :destroy
  accepts_nested_attributes_for :sale_properties

  has_option :currency, :default => "€", :type => :string
  
  preference :currency, :string, :default => "€"
  preference :listing_description_length, :integer, :default => 120
  preference :listing_omission, :string, :default => "[...]"

  attr_accessible :preferred_currency,  :preferred_listing_description_length, :preferred_listing_omission
  
  def content_type
    'SaleProperty'
  end
end
