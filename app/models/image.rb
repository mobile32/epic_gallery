class Image < ApplicationRecord
  mount_uploader :image_file,  ImageUploader

  has_and_belongs_to_many :galleries
  belongs_to :user
end
