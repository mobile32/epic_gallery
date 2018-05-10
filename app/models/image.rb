class Image < ApplicationRecord
  mount_uploader :image_file,  ImageUploader

  has_and_belongs_to_many :galleries
  has_and_belongs_to_many :tags
  belongs_to :user

  validates :image_file, presence: true
end
