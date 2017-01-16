class AddSeasonPrototypesTable < ActiveRecord::Migration
   def up
     unless table_exists?(:season_prototypes)
      create_table :season_prototypes, :force => true do |t|
        t.references :site
        t.string :title
        t.date :start_date
        t.date :end_date
        t.timestamps
      end
      end
    end

    def down
      drop_table :season_prototypes
    end
  end
 