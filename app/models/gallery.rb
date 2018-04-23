class Gallery < ApplicationRecord
  belongs_to :user
  has_many :images

  mount_uploader :cover_image, ImageUploader
end
