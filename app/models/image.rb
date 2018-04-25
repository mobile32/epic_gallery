class Image < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :galleries

  mount_uploader :image_file, ImageUploader
end
