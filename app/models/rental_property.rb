class RentalProperty < Content

  acts_as_indexed :fields => [:title]

  #----- Associations --------------------------------------------------------------

  has_one :meta,
  :class_name => "RentalPropertyOption",
  :foreign_key => :property_id,
  :dependent => :destroy

  accepts_nested_attributes_for :meta

  has_many :rental_property_seasons,
  :foreign_key => :property_id,
  :order => :start_date,
  :include => [:translations, :rates],
  :dependent => :destroy


  accepts_nested_attributes_for :categorizations, :allow_destroy => true
  attr_accessible :categorizations_attributes, :categories_ids_attributes, :category_ids
  accepts_nested_attributes_for :rental_property_seasons, :allow_destroy => true,
  :reject_if => proc { |a| a[:title].blank? || a[:start_date].blank? || a[:end_date].blank? }

  has_many :rates,
  :class_name => "RentalPropertyRate",
  :through => :rental_property_seasons

  has_many :content_options, :as => :owner, :dependent => :destroy
  accepts_nested_attributes_for :content_options, :reject_if => lambda { |ov| ov[:option_value_id].blank? }
  has_many :option_values, :through => :content_options
  has_many :option_types, :through => :content_options

  attr_accessible :meta_attributes, :content_options_attributes, :rental_property_seasons_attributes

  has_many :rental_property_assignments, :foreign_key => "property_id", :dependent => :destroy

  #----- Delegate ----------------------------------------------------------------
  alias :seasons :rental_property_seasons
  delegate(:show_in_homepage, :bathroom_count, :bedroom_count,
   :currency, :lat_long, :promo_text, :pets_policy,
   :children_policy, :price_note, :area, :city, :badge,
   :realty_agent, :end_display, :info_title, :info_body, :video_url, :to => :meta)


  #----- Class methods -----------------------------------------------------------
  class << self
    def with_promo()
      joins(:meta => :translations).where("rental_property_option_translations.locale = '#{Globalize.locale.to_s}' AND rental_property_option_translations.promo_text IS NOT NULL AND rental_property_option_translations.promo_text != ''")
    end

    def with_info()
      joins(:meta => :translations).where("rental_property_option_translations.locale = '#{Globalize.locale.to_s}' AND rental_property_option_translations.info_title IS NOT NULL AND rental_property_option_translations.info_title != ''")
    end

    def by_title()
      with_translations().order("content_translations.title ASC")
    end

    def by_price(currency="eur")
      joins(:meta).order("rental_property_options.#{currency}_min_price ASC")
    end

    def by_bedroom_count()
      joins(:meta).order("rental_property_options.bedroom_count ASC")
    end

    def with_realty_category(category_id)
      includes(:realty_categorizations).where(:realty_categorizations => {:category_id => category_id})
    end

    def with_bedroom_count(count)
      joins(:meta).where("rental_property_options.bedroom_count >= ?", count.to_i).by_bedroom_count
    end
    def in_area(area_id)
      joins(:meta).where(:rental_property_options => {:area_id => area_id})
    end
    def in_city(city_id)
      joins(:meta).where(:rental_property_options => {:city_id => city_id})
    end
    def rates_between(from, to, currency="eur")
      joins(:meta).where("rental_property_options.#{currency}_max_price IS NOT NULL AND rental_property_options.#{currency}_min_price IS NOT NULL AND rental_property_options.#{currency}_min_price >= ? AND rental_property_options.#{currency}_max_price <= ?", from, to).order("#{currency}_min_price ASC")
    end
    def rates_less_than(max_rates, currency="eur")
      joins(:meta).where("rental_property_options.#{currency}_min_price IS NOT NULL AND rental_property_options.#{currency}_min_price <= ?", max_rates).order("#{currency}_min_price ASC")
    end
    def rates_more_than(min_rates, currency="eur")
      joins(:meta).where("rental_property_options.#{currency}_min_price IS NOT NULL AND rental_property_options.#{currency}_min_price >= ?", min_rates).order("#{currency}_min_price ASC")
    end
    def end_display
      joins(:meta).where(:rental_property_options => {:end_display => true})
    end
    def with_pool
      joins(:meta).where(:rental_property_options => {:pool => true})
    end
    def with_beachfront
      joins(:meta).where(:rental_property_options => {:beachfront => true})
    end
    def in_homepage
      joins(:meta).where(:rental_property_options => {:show_in_homepage => true})
    end
  end

  def season_all_year?
    self.rental_property_seasons.count == 1 &&  self.rental_property_seasons.first.all_year?
  end

  def promo?
    !ActionView::Base.full_sanitizer.sanitize(self.promo_text).blank?
  end

  def update_max_min_rates
    eur_max_rate = self.rates.maximum(:eur_price)
    eur_min_rate = self.rates.minimum(:eur_price)
    usd_max_rate = self.rates.maximum(:usd_price)
    usd_min_rate = self.rates.minimum(:usd_price)
    self.meta.update_attributes({
      :eur_max_price => eur_max_rate,
      :eur_min_price => eur_min_rate,
      :usd_max_price => usd_max_rate,
      :usd_min_price => usd_min_rate
      })
  end

  def available_option_types
    o = OptionType.with_classname(self.class.name)
    selected_option_types = []
    self.option_types.each do |option|
      selected_option_types << option
    end
    o.delete_if {|ot| selected_option_types.include? ot}
  end

  def secondary_currency
    return "€" if self.currency == "$"
    return "$"
  end


end
