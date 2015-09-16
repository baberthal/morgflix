class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.belongs_to :series, index: true, null: false
      t.integer :tvdb_banner_id, index: true
      t.string :banner_path
      t.string :banner_type, index: true
      t.string :dimensions, index: true
      t.string :language, index: true
      t.float :rating, index: true
      t.integer :rating_count, index: true
      t.string :thumbnail_path
      t.string :vignette_path
      t.string :local_banner_path
      t.string :season, index: true
      t.binary :image
      t.timestamps null: false
    end
  end
end
