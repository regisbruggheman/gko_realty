module Gko
  module Realty
    class Engine < ::Rails::Engine
      include Gko::Engine

      initializer 'gko-realty.require_section_types' do
        config.to_prepare { 
          require_dependency 'rental_property_list' 
          require_dependency 'sale_property_list'
          require_dependency 'annual_rental_list'
          require_dependency 'sale_property_selection_list'
          require_dependency 'rental_property_selection_list'
        }
      end
      
      config.after_initialize do
        Gko.register_engine(Gko::Realty)
      end
    end
  end
end