class RentalPropertyInquiriesController < InquiriesController
  before_filter :set_inquiry, :only => :new
  #before_filter :clean_dates, :only => :create

  protected
  
    def set_inquiry
      @rental_property_inquiry ||= RentalPropertyInquiry.new(:site => site, :property_id => params[:property_id])
      @rental_property_inquiry.set_default_values if Rails.env.development?
    end
  
    def deliver
      InquiryMailer.rental_property_notification(resource).deliver
    end  

  private

    def clean_dates
      if params.has_key?(:rental_property_inquiry)
        params[:rental_property_inquiry][:start_date] = Date.civil(
          params[:rental_property_inquiry].delete(:'start_date(1i)').to_i,
          params[:rental_property_inquiry].delete(:'start_date(2i)').to_i,
          params[:rental_property_inquiry].delete(:'start_date(3i)').to_i)
    
        params[:rental_property_inquiry][:end_date] = Date.civil(
          params[:rental_property_inquiry].delete(:'end_date(1i)').to_i,
          params[:rental_property_inquiry].delete(:'end_date(2i)').to_i,
          params[:rental_property_inquiry].delete(:'end_date(3i)').to_i)
      end
    end

end
