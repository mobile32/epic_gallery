class Gallery < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :images


  mount_uploader :cover_image, ImageUploader
end
