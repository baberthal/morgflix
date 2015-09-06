class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.integer :external_id
      t.string :language, null: false, default: 'en'
      t.string :name, null: false
      t.text :overview
      t.datetime :first_aired
      t.string :network
      t.string :imdb_id
      t.string :zap2it_id
      t.timestamps null: false
    end
  end
end
