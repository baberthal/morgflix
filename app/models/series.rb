class Series < ActiveRecord::Base
  include Archivable
  include Scrapable

  validates :name, presence: true, uniqueness: true
  scope :latest, -> { order(created_at: :desc).limit(5) }

  serialize :genres, Array

  has_many :banners

  def needs_full_update?
    external_id && overview.nil?
  end
end
