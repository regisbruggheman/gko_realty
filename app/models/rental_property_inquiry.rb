class RentalPropertyInquiry < Inquiry

  has_option :person_count, :type => :integer
  has_option :adults_count, :type => :integer
  has_option :children_count, :type => :integer
  has_option :start_date, :type => :date
  has_option :end_date, :type => :date
  has_option :property_id, :type => :integer

  validates :property_id, :presence => true
  
  #TODO Cleanup
  def set_default_values
    if Rails.env.development?
      self.email = "regis@joufdesign.com"
      self.message = "Thanks for the test you sent."
      self.name = "Regis Bruggheman"
      self.start_date = Date.today + 14
      self.end_date = Date.today + 21
    end
  end
  
  def property
    RentalProperty.find(self.property_id)
  end
end
