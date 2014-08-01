class Liveset < ActiveRecord::Base
  has_many :tracks
  validates :artist, presence: true
  validates :title, presence: true
  validates :filepath, presence: true, uniqueness: true
  validates :date_aired, date: true
end
