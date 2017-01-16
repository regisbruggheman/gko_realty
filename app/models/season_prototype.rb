class SeasonPrototype < ActiveRecord::Base
  
  belongs_to_site
  
  translates :title
  
  class Translation
    attr_accessible :locale
  end
  
  default_scope :order => 'season_prototypes.start_date ASC'
  validates :start_date, :end_date, :presence => true
  validates :title, :presence => true, :uniqueness => [:site_id]
  
  attr_accessible :title, :start_date, :end_date
  
  after_save :update_rental_properties

  def labelize
    translated_locales.include?(Globalize.locale) ? self.title : "<span class='warning'>!</span>(#{read_attribute(:title, :locale => I18n.default_locale)})".html_safe
  end
  
  protected
  
  
  def update_rental_properties
    properties = self.site.rental_properties
    properties.each do |p|
      p.seasons.each do |s|
        if s.start_date == self.start_date && s.end_date == self.end_date
         
        end
      end
    end
  end
  
end
