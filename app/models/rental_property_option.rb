class RentalPropertyOption < ActiveRecord::Base

  TRANSLATED_FIELD = [
    :children_policy, :description, :promo_text, :pets_policy, :price_note, :badge, :info_title, :info_body
  ].freeze


  #belongs_to :statute

  translates *TRANSLATED_FIELD

  class Translation
    attr_accessible :locale
  end

  belongs_to :property,
    :class_name => "RentalProperty",
    :foreign_key => :property_id,
    :touch => true
  belongs_to :area
  belongs_to :city
  belongs_to :country
  belongs_to :realty_agent

  attr_accessible :children_policy, :notes, :bedroom_count,
                  :bathroom_count, :room_count, :max_guest, :currency,
                  :code, :eur_min_price, :eur_max_price, :usd_min_price,
                  :usd_max_price, :lat_long, :postcode, :city_id, :province_state,
                  :country_id, :area_id, :property_id, :show_in_homepage,
                  :start_rates_bedroom_count, :description, :promo_text,
                  :realty_agent_id, :pets_policy, :price_note, :pool,
                  :beachfront, :end_display, :badge, :info_title, :info_body, :video_url#, :statute_id, :statute
  #validates :property_id, :presence => true

  before_save do |r|
    # set promo_text to NULL if empty
    unless ActionView::Base.full_sanitizer.sanitize(r.clone.promo_text).presence
      r.promo_text = nil
    end
    unless ActionView::Base.full_sanitizer.sanitize(r.clone.info_body).presence
      r.info_body = nil
    end
    r.info_title = r.info_title.presence
  end

  def currency
    read_attribute(:currency) || property.section.preferred_currency
  end

end
