class Series < ActiveRecord::Base
  include Archivable
  include Scrapable

  validates :name, presence: true, uniqueness: true
  after_create :fetch_info
end
