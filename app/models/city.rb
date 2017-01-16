class City < ActiveRecord::Base

  belongs_to :site, :touch => true

  has_many :areas, :order => 'name', :dependent => :destroy
  accepts_nested_attributes_for :areas, :reject_if => lambda { |area| area[:name].blank? }, :allow_destroy => true

  default_scope :order => 'name'
  validates :name, :presence => true, :uniqueness => true, :length => 3..80

  attr_accessible :name, :site_id, :areas_attributes
end
