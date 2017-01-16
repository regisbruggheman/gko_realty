class RealtyAgent < ActiveRecord::Base
  image_accessor :image
  # What is the max image size a user can upload
  MAX_SIZE_IN_MB = 1
  # What is the max image format a user can upload
  FILE_TYPES = %w(image/jpg image/jpeg image/png image/gif)

  belongs_to :site
  has_many :rental_property_options, :dependent => :nullify
  has_many :rental_properties, :through => :rental_property_options
  has_many :sale_property_options, :dependent => :nullify
  has_many :sale_properties, :through => :sale_property_options
  has_many :annual_rental_options, :dependent => :nullify
  has_many :annual_rentals, :through => :annual_rental_options

  acts_as_list :scope => "site_id"

  validates :site_id, :name, :presence => true
  validates :image, :length => { :maximum => MAX_SIZE_IN_MB.megabytes }
  validates_property :mime_type, :of => :image, :in => FILE_TYPES,
                     :message => :incorrect_file_type

  attr_accessible :name, :grade, :email, :primary_phone_number_name,
    :primary_phone_number, :secondary_phone_number_name,
    :secondary_phone_number, :alt_phone_number_name,
    :alt_phone_number, :site_id, :image

  def thumbnail(geometry = nil)
    if image.present?
      geometry ||= Site.current.preferred_realty_agent_image_size
      image.thumb(geometry)
    end
  end

end
