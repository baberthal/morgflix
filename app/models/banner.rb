class Banner < ActiveRecord::Base
  belongs_to :series
  validates :series, presence: true
  after_create :download

  def download
    BannerWorker.perform_async(id)
  end
end
