class AnnualRentalList < Section
  include Extensions::Models::IsList
  has_many  :annual_rentals, 
            :foreign_key => 'section_id', 
            :dependent => :destroy
  accepts_nested_attributes_for :annual_rentals  
  
  has_option :currency, :default => "€", :type => :string
  has_option :listing_description_length, :type => :integer, :default => 120
  has_option :listing_omission, :default => "[...]"
  
  attr_accessible :annual_rentals_attributes
  
  def content_type
   'AnnualRental'
  end
end