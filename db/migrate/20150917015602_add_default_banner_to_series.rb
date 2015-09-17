class AddDefaultBannerToSeries < ActiveRecord::Migration
  def change
    add_column :series, :default_banner, :string
  end
end
