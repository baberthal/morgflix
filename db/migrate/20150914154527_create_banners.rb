class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.belongs_to :series, index: true, null: false
      t.string :name
      t.binary :image
      t.timestamps null: false
    end
  end
end
