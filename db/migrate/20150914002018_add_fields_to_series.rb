class AddFieldsToSeries < ActiveRecord::Migration
  def change
    change_table :series do |t|
      t.string :air_day_of_week
      t.string :air_time
      t.string :content_rating
      t.text :genres
      t.float :rating
      t.integer :rating_count
      t.integer :runtime
      t.integer :tvdb_series_id
      t.string :status
      t.datetime :added
      t.integer :added_by
      t.integer :tvdb_last_update
      t.integer :tvdb_tms_wanted_old
      t.text :banner_options
    end
  end
end
