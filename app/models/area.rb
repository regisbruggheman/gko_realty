require 'digest/md5'

class Area < ActiveRecord::Base

  belongs_to :city, :touch => true 
  default_scope :order => 'name'
  validates :name, :presence => true, :uniqueness => true, :length => 3..60
  has_many :rental_property_options, :dependent => :nullify
  has_many :rental_properties, :through => :rental_property_options
  has_many :sale_property_options, :dependent => :nullify
  has_many :sale_properties, :through => :sale_property_options
  
  attr_accessible :name, :city_id
  
  def self.cache_key
    Digest::MD5.hexdigest("#{maximum(:updated_at)}.try(:to_i)-#{count}")
  end
end
