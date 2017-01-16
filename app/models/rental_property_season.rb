class RentalPropertySeason < ActiveRecord::Base
  
  translates :title
  
  class Translation
    attr_accessible :locale
  end
  
  #----- Class methods -----------------------------------------------------------
  default_scope :order => 'rental_property_seasons.start_date ASC'
  #----- Associations ------------------------------------------------------------
  
  belongs_to :property, 
    :class_name => "RentalProperty", 
    :foreign_key => :property_id,
    :touch => true
    
  has_many :rates, 
    :class_name => "RentalPropertyRate", 
    :dependent => :destroy, 
    :foreign_key => :season_id,
    :order => 'rental_property_rates.bedroom_count ASC'
  accepts_nested_attributes_for :rates, :allow_destroy => true, :reject_if => :all_blank
  
  attr_accessible :property_id, :title, :start_date, :end_date, :minimum_night, :rates_attributes
  
  validates :start_date, :end_date, :presence => true
  
  before_save do |record|
    record.minimum_night = 1 unless record.minimum_night.present?
  end
  after_save do |record|
    record.property.update_max_min_rates
  end

  # Adding properties and rates on creation based on a chosen prototype
  attr_reader :prototype_id
  def prototype_id=(value)
    @prototype_id = value.to_i
  end
  
  def match_prototype?(prototype)
    return (prototype.start_date == self.start_date && prototype.end_date == self.end_date && prototype.title == self.title)
  end
  
  def all_year?
    364 < ((self.end_date.to_time - self.start_date.to_time).to_i / (24*60*60))
  end
  
  def labelize
    translated_locales.include?(Globalize.locale) ? self.title : "<span class='label warning'>!</span>(#{read_attribute(:title, :locale => I18n.default_locale)})".html_safe
  end
  
  
  #----- Callbacks -------------------------------------------------------------
  #def validate
  #  errors.add(:end_date, 'must be after start date') if ! self.start_date.nil? and ! self.end_date.nil? and self.end_date < self.start_date
  #end
end
