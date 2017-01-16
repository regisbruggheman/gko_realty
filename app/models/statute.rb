class Statute < ActiveRecord::Base
  
  belongs_to :site, :touch => true
  #has_many :rental_property_options, :dependent => :nullify
  has_many :sale_property_options, :dependent => :nullify
  has_many :annual_rental_options, :dependent => :nullify
  
  translates :title
  
  class Translation
    attr_accessible :locale
  end

  validates :site_id, :presence => true
  
  attr_accessible :site, :site_id, :title, :name
  
  def self.with_class_name(name)  
    where(:name => name)
  end
  
end