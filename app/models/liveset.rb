class Liveset < ActiveRecord::Base

  has_many :tracks, inverse_of: :liveset

  validates :artist,
    presence: true

  validates :title,
    presence: true

  validates :filepath,
    presence: true

  # For will_paginate gem
  self.per_page = 10
end
