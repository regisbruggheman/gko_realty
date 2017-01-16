class SalePropertyInquiry < Inquiry

  has_option :property_id, :type => :integer
  validates :property_id, :presence => true
  
  #TODO Cleanup
  def set_default_values
    if Rails.env.development?
      self.email = "regis@joufdesign.com"
      self.message = "Thanks for the test you sent."
      self.name = "Regis Bruggheman"
    end
  end

  
  def property
    SaleProperty.find(self.property_id)
  end

end
