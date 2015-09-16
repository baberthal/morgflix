class Series < ActiveRecord::Base
  include Archivable
  include Scrapable

  validates :name, presence: true, uniqueness: true
  validates :external_id, presence: true, uniqueness: true
  scope :latest, -> { order(created_at: :desc).limit(5) }

  serialize :genres, Array

  has_many :banners
  has_many :actors
end
