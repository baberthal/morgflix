class Series < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
end
