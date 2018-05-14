class Image < ApplicationRecord
  scope :with_selected_tags, ImagesWithSelectedTagsQuery

  mount_uploader :image_file,  ImageUploader

  has_and_belongs_to_many :galleries

  has_many :image_tags, dependent: :destroy
  has_many :tags, through: :image_tags

  belongs_to :user

  validates :image_file, presence: true
end
