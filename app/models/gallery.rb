class Gallery < ApplicationRecord
  mount_uploader :cover_image,  ImageUploader

  has_and_belongs_to_many :images
  has_and_belongs_to_many :tags
  belongs_to :user

  validates :title, presence: true
end
