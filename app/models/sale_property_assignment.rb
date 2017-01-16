class SalePropertyAssignment < ActiveRecord::Base 
    
    belongs_to :sale_property,
    :foreign_key => "property_id",
    :touch => true
    
    belongs_to :sale_property_selection_list,
    :foreign_key => "selection_id",
    :touch => true

    validates :property_id, :selection_id, :presence => true
    validates_uniqueness_of :property_id, :scope => :selection_id

    acts_as_list :scope => "selection_id"

end