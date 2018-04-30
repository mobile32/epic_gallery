class Upload
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :images, :user

  validates :images, presence: true

  def initialize(images:, user:)
    @images = images
    @user   = user
  end

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      images.each do |image|
        Image.create!(user: user, image_file: image)
      end
    end
    true
  end
end
