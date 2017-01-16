class GlobalizeSeasonPrototypes < ActiveRecord::Migration
  def self.up
    unless table_exists?(:season_prototype_translations)
    SeasonPrototype.create_translation_table!({
      :title => :string
    }, {:migrate_data => true})
    end
  end
  def self.down
    SeasonPrototype.drop_translation_table! :migrate_data => true
  end
end
 