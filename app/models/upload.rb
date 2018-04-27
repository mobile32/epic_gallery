class Upload < ApplicationRecord
  has_and_belongs_to_many :galleries
  mount_uploaders :images, ImageUploader

  belongs_to :user
end
