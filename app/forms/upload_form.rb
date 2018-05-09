class UploadForm < Patterns::Form
  param_key "upload"

  attribute :images
  attribute :galleries_ids

  validates :images, presence: true

  private

  def persist
    ActiveRecord::Base.transaction do
      image_db_models = images.map do |image|
        Image.create!(user: form_owner, image_file: image)
      end

      galleries_ids.select(&:present?).each do |gallery_id|
        Gallery.find(gallery_id).images << image_db_models
      end
    end
    true
  end
end