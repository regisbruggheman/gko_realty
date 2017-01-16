module RealtyHelper
  def annual_price_value(property)
    if property.price == 0 || property.price.blank?
      price = t("on_request")
    else
      price = number_to_currency(property.price, :precision => 2, :unit => site.preferred_currency)
    end
  end
  
  def rental_min_price_value(property)
    currency = property.meta.currency || property.section.currency
    price = if currency == "$"  
      #property.meta.usd_min_price
      property.rates.minimum(:usd_price)
     else
       property.rates.minimum(:eur_price)
       #property.meta.eur_min_price
    end

    if price == 0 || price.blank?
      price = t("on_request")
    else
      price = number_to_currency(price, :precision => 2, :unit => currency)
    end
  end

  def sale_price_value(property, show_exchange = false)
    currency = property.currency || property.section.currency
    if property.price == 0 || property.price.blank? ||  !property.show_price_in_frontend 
      result = t("price_on_request")
    else
      result = number_to_currency(property.price, :unit => property.currency, :precision => 2)
      if show_exchange && property.exchange_price.present? && property.exchange_price > 0
        exchange_currency = currency == "$" ? "€" : "$"
        result += " (#{number_to_currency(property.exchange_price, :unit => exchange_currency, :precision => 2)})"
      end
    end
    return result
  end
  
  def realty_meta_tag(tag, value)
    content_tag("span", :class => "tag #{tag.to_s}") do
      "<strong>#{t(:"realty.metas.#{tag.to_s}")}:</strong> #{value}".html_safe
    end if value.present?
  end
  
  def price_for_rate(currency, price = nil)
    if price.present?
      number_to_currency(price, :precision => 2, :unit => currency)
    else 
      t(:'price_on_request')
    end
  end 
  
  def exchange_rate(currency, price = nil)
    if price.present?
      return number_to_currency(price, :precision => 2, :unit => currency)
    end 
  end
  
  def secondary_currency_field(record)
    @secondary_currency_field ||= begin
      currency = if record.currency == "$"
        :eur_price
      else
        :usd_price
      end
      currency
    end
  end
  
  def currency_field(record)
    @currency_field ||= begin
      currency = if record.currency == "$"
        :usd_price
      else
        :eur_price
      end
      currency
    end
  end
end
