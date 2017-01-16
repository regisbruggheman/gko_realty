class AnnualRentalInquiry < Inquiry
  
  has_option :bedroom_count, :type => :string
  has_option :max_price, :type => :string
  has_option :area, :type => :string
  validates :bedroom_count, :presence => true
  validates :max_price, :presence => true
  
  #TODO Cleanup
  def set_default_values
    if Rails.env.development?
      self.email = "regis@joufdesign.com"
      self.message = "Thanks for the test you sent."
      self.name = "Regis Bruggheman"
    end
  end

end