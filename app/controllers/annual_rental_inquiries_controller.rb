class AnnualRentalInquiriesController < InquiriesController
  before_filter :set_inquiry, :only => :new
  protected
    def set_inquiry
      @annual_rental_inquiry ||= AnnualRentalInquiry.new(:site => site)
      @annual_rental_inquiry.set_default_values if Rails.env.development?
    end
    def deliver
      InquiryMailer.annual_rental_notification(resource).deliver
    end  
end
