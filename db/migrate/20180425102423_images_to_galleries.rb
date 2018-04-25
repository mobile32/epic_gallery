class ImagesToGalleries < ActiveRecord::Migration[5.1]
  def change
    create_table :images_galleries do |t|
      t.belongs_to :images, index: true, foreign_key: true, null: false
      t.belongs_to :galleries, index: true, foreign_key: true, null: false
    end
  end
end
