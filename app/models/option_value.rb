class OptionValue < ActiveRecord::Base
  
  translates :presentation
  
  class Translation
    attr_accessible :locale
  end
  
  belongs_to :option_type
  has_many :content_options, :dependent => :destroy
  acts_as_list :scope => :option_type
  attr_accessible :option_type_id, :name, :position, :presentation
end