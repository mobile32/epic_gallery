class Tag < ApplicationRecord
  has_and_belongs_to_many :images
  has_and_belongs_to_many :galleries

  validates :name, presence: true
end
