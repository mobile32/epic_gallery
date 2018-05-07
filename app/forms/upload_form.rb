class UploadForm < Patterns::Form
  param_key "upload"

  attribute :images
  validates :images, presence: true

  private

  def persist
    ActiveRecord::Base.transaction do
      images.each do |image|
        Image.create!(user: form_owner, image_file: image)
      end
    end
    true
  end
end