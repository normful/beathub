class Liveset < ActiveRecord::Base

  has_many :tracks

  validates :artist,
    presence: true

  validates :title,
    presence: true

  validates :filepath,
    uniqueness: true,
    presence: true

  validates :cuepath,
    uniqueness: true

  validates :zippath,
    uniqueness: true

  validates :date_aired,
    date: true

  # For will_paginate gem
  self.per_page = 10
end
