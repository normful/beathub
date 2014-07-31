class Track < ActiveRecord::Base

  belongs_to :set

  validates: artist, presence: true
  validates: title, presence: true
  validates: filepath, presence: true
  validates: track_number, numericality { greater_than: 0, only_integer: true }

end