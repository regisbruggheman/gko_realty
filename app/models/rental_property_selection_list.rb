class RentalPropertySelectionList < Section  
    
    has_many :rental_property_assignments,
    :foreign_key => "selection_id",
    :order => "rental_property_assignments.position ASC",
    :dependent => :destroy
    
    has_many :rental_properties, 
    :foreign_key => "property_id", 
    :order => "rental_property_assignments.position ASC",
    :through => :rental_property_assignments

    accepts_nested_attributes_for :rental_property_assignments, 
    :reject_if => lambda { |ov| ov[:property_id].blank? }, 
    :allow_destroy => true

    attr_accessible :rental_property_assignments_attributes

    after_initialize :set_default_values
    before_save :set_default_values

    private

    def set_default_values
        self.robot_follow = 0
        self.robot_index = 0
    end

end