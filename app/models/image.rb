class Image < ApplicationRecord
  belongs_to :user
  belongs_to :gallery

  mount_uploader :image, ImageUploader
end
