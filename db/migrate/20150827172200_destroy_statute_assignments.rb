class DestroyStatuteAssignments < ActiveRecord::Migration
  def change
    drop_table :statute_assignments
    add_column :rental_property_options, :statute_id, :integer
  end
end