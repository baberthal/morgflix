class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.integer :tvdb_actor_id, null: false, index: true
      t.belongs_to :series, index: true
      t.string :name, index: true
      t.string :image
      t.string :role, index: true
      t.integer :sort_order, index: true
      t.timestamps null: false
    end
  end
end
