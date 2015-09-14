class Banner < ActiveRecord::Base
  belongs_to :series
  validates :series, presence: true
end
