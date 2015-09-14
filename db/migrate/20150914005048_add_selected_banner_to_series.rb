class AddSelectedBannerToSeries < ActiveRecord::Migration
  def change
    add_column :series, :selected_banner, :string
  end
end
