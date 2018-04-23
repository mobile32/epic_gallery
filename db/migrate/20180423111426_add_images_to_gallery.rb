class AddImagesToGallery < ActiveRecord::Migration[5.1]
  def change
    add_reference :images, :gallery, foreign_key: true
  end
end
