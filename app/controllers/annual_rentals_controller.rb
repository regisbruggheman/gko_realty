class AnnualRentalsController < ContentsController
  respond_to :html, :js, :pdf
  has_scope :with_bedroom_count, :only => :index 
  has_scope :in_area, :only => :index
  nested_belongs_to :annual_rental_list
  before_filter :set_inquiry, :only => :show

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "pdf_#{resource.permalink}", 
          :disposition => "inline", # default 'inline'
          :formats => [:pdf, :html], 
          :show_as_html => params[:debug].present?,
          :layout => "pdf", 
          :encoding => "UTF-8"#,
          #:header => { :right => "#{resource.permalink} [page] of [topage]" }
      end
    end
  end
  
  protected
    def load_resources
      end_of_association_chain.includes(:images, :meta).published.with_translations(I18n.locale)
    end
    
    def order_all(collection)
      ord = if ordering?
        params[:search][:order]
      else
        'annual_rental_options.price ASC'
      end
      collection.order(ord.to_s)
    end

    def set_inquiry
      @annual_rental_inquiry = AnnualRentalInquiry.new(
        :site => site, 
        :property_id => resource.id
      )
      @annual_rental_inquiry.set_default_values if Rails.env.development?
    end
end
