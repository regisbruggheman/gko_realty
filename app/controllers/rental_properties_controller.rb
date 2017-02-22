class RentalPropertiesController < ContentsController
  respond_to :html, :js, :pdf
  belongs_to :rental_property_list
  before_filter :get_properties_in_promotions
  before_filter :set_inquiry, :only => :show
  has_scope :with_bedroom_count, :only => :index
  has_scope :in_area, :only => :index
  has_scope :in_city, :only => :index
  has_scope :with_title, :only => :index
  has_scope :with_category, :only => :index
  has_scope :with_promo, :type => :boolean, :only => :index
  has_scope :with_infos, :type => :boolean, :only => :index
  has_scope :with_end_displays, :type => :boolean, :only => :index
  has_scope :with_pool, :type => :boolean, :only => :index
  has_scope :with_beachfront, :type => :boolean, :only => :index
  has_scope :by_title, :only => :index

  self.includes = [:meta, :content_options, :rental_property_seasons]

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "pdf_#{resource.permalink}",
          :disposition => "inline", # default 'inline'
          :formats => [:pdf, :html],
          :show_as_html => 0,#params[:debug].present?,
          :layout => "pdf",
          :encoding => "UTF-8"#,
          #:header => { :right => "#{resource.permalink} [page] of [topage]" }
      end
    end
  end

  def promotions
    get_properties_in_promotions.paginate(:page => params[:page] || 1, :per_page => parent.contents_per_page)
  end

  def infos
    get_properties_with_infos.paginate(:page => params[:page] || 1, :per_page => parent.contents_per_page)
  end

  def end_displays
    get_properties_with_end_display.paginate(:page => params[:page] || 1, :per_page => parent.contents_per_page)
  end

  protected

    def get_properties_in_promotions
      @properties_in_promotions ||= current_site.rental_properties.published.with_globalize.with_promo
    end

    def get_properties_with_infos
      @properties_with_infos ||= current_site.rental_properties.published.with_globalize.with_info
    end

    def get_properties_with_end_display
      @properties_with_end_display ||= current_site.rental_properties.published.with_globalize.end_display
    end

    def load_resource_associations
      super
      @resource_meta = resource.meta
      @seasons = resource.seasons
    end

    def load_resources
      if params[:with_promo].present?
        promotions
      elsif params[:with_infos].present?
        infos
      elsif params[:with_end_displays].present?
        end_displays
      elsif searching?
        params[:page] = params[:search][:page] || 1
        if params[:search][:order] == "by_price"
          collection = end_of_association_chain.published.includes(self.includes).with_globalize.by_price().limit(parent.contents_per_page)
        elsif params[:search][:order] == "by_title"
          collection = end_of_association_chain.published.includes(self.includes).with_globalize.by_title().limit(parent.contents_per_page)
        else
          collection = end_of_association_chain.published.includes(self.includes).with_globalize.limit(parent.contents_per_page)
        end
      else
        collection = end_of_association_chain.published.includes(self.includes).with_globalize.limit(parent.contents_per_page)
        if parent.default_order == "rand"
         collection = collection.order('RAND()')
        elsif parent.default_order == "position"
          collection = collection.order('position')
        elsif parent.default_order == "price"
          collection = collection.by_price()
        elsif parent.default_order == "bedroom_count"
          collection = collection.by_bedroom_count()
        else
          collection = collection.by_title()
        end
        collection
      end
    end

    def order_all(c)
      ordering? ? c.order(params[:search][:order]) : c
      #collection
    end

    def filter_collection(collection)
      col = super
      if searching? && params[:search][:price].present?
        # Currency is usd by default !!!!!!
        # TODO : authorize eur currency ??
        currency = "eur"
        pricing = params[:search][:price].parameterize.underscore
        if pricing == "less_than_4000"
          col = col.rates_less_than(4000, currency)
        elsif pricing == "4000_10000"
          col = col.rates_between(4000, 10000, currency)
        elsif pricing == "more_than_10000"
          col =  col.rates_more_than(10000, currency)
        end
      end
      return col
    end

    def set_inquiry
      @rental_property_inquiry = RentalPropertyInquiry.new(:site => current_site, :property_id => resource.id)
      @rental_property_inquiry.set_default_values if Rails.env.development?
    end
end
