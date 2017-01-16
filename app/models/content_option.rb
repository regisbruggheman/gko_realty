class ContentOption < ActiveRecord::Base
  belongs_to :option_type, :touch => true
  belongs_to :option_value, :touch => true
  belongs_to :owner, :polymorphic => true, :touch => true
  
  validates :option_value_id, :option_type_id, :presence => true
  
  attr_accessible :owner_id, :owner_type, :option_type_id, :option_value_id
end