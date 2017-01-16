class OptionType < ActiveRecord::Base
  
  translates :presentation
  
  class Translation
    attr_accessible :locale
  end
  
  has_many :content_options, :dependent => :destroy
  has_many :option_values, :order => :position, :dependent => :destroy
  belongs_to :site
  validates :site_id, :name, :presentation, :class_name, :presence => true
  
  default_scope :order => "option_types.position ASC" 
    
  accepts_nested_attributes_for :option_values, :reject_if => lambda { |ov| ov[:name].blank? || ov[:presentation].blank? }, :allow_destroy => true
  
  attr_accessible :option_values_attributes, :name, :presentation, :site_id, :position, :class_name
  
  def self.with_classname(name)  
    where(:class_name => name)
  end
end
