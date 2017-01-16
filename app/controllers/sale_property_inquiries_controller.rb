class SalePropertyInquiriesController < InquiriesController
  before_filter :set_inquiry, :only => :new
  protected
    def set_inquiry
      @sale_property_inquiry ||= SalePropertyInquiry.new(:site => site, :property_id => params[:property_id])
      @sale_property_inquiry.set_default_values if Rails.env.development?
    end
    def deliver
      InquiryMailer.sale_property_notification(resource).deliver
    end  
end
