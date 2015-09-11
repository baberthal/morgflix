class AddBannerInfoToSeries < ActiveRecord::Migration
  def change
    add_column :series, :banner_info, :string
  end
end
