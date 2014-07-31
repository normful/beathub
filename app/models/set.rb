class Set < ActiveRecord::Base

  has_many :tracks

  validates: artist, presence: true
  validates: title, presence: true
  validates: filepath, presence: true
  validates: date_aired, date: true

end