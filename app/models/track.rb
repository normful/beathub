class Track < ActiveRecord::Base

  belongs_to :liveset, inverse_of: :tracks

  validates :artist,
    presence: true

  validates :title,
    presence: true

  validates :track_number,
    numericality: { greater_than: 0, only_integer: true },
    presence: true

end
