class SalePropertiesController < ContentsController
  respond_to :html, :js, :pdf

  belongs_to :sale_property_list
  before_filter :set_inquiry, :only => :show

  has_scope :with_bedroom_count, :in_city, :in_area, :with_title, :with_category, :only => :index

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "pdf_#{resource.permalink}",
          :disposition => "inline", # default 'inline'
          :formats => [:pdf, :html],
          :show_as_html => 0, #params[:debug].present?,
          :layout => "pdf",
          :encoding => "UTF-8"#,
          #:type => 'application/pdf',
        #  :save_to_file => Rails.root.join('pdfs', "#{resource.permalink}.pdf")

        #html = render_to_string(:action => :show, :layout => "pdf")
        #pdf = WickedPdf.new.pdf_from_string(html)

        #send_data(pdf,
        #  :filename => "pdf_#{resource.permalink}",
        #  :disposition => 'attachment')
      end
    end
  end

  def download
    html = render_to_string(:action => :show, :layout => "pdf")
    pdf = WickedPdf.new.pdf_from_string(html)

    send_data(pdf,
      :filename => "pdf_#{resource.permalink}",
      :disposition => 'attachment')
  end

  protected
    def load_resources
      params[:page] = (params[:search][:page] || 1) if searching?
      end_of_association_chain.includes(:images, :meta).published.with_translations(I18n.locale)
    end

    def order_all(c)
      if ordering?
        if params[:search][:order] == "by_price"
          c = c.by_price().limit(parent.contents_per_page)
        elsif params[:search][:order] == "by_title"
          c = c.by_title().limit(parent.contents_per_page)
        else
          c = c.by_price().limit(parent.contents_per_page)
        end
      end
      c
    end

    def set_inquiry
      @sale_property_inquiry = RentalPropertyInquiry.new(:site => site, :property_id => resource.id)
      @sale_property_inquiry.set_default_values if Rails.env.development?
    end
end
