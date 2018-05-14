class UploadForm < Patterns::Form
  param_key "upload"

  attribute :images
  attribute :galleries_ids
  attribute :tags

  validates :images, presence: true

  private

  def persist
    ActiveRecord::Base.transaction do
      tags_db_models = tags.select(&:present?).map do |tag_name|
        Tag.find_or_create_by(name: tag_name)
      end

      image_db_models = images.map do |image|
        last_image = Image.create!(user: form_owner, image_file: image)

        last_image.tags << tags_db_models
      end

      galleries_ids.select(&:present?).each do |gallery_id|
        Gallery.find(gallery_id).images << image_db_models
      end
    end
    true
  end
end