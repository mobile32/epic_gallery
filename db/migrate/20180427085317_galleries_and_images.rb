class GalleriesAndImages < ActiveRecord::Migration[5.1]
  def change
    create_table :galleries do |t|
      t.string :cover_image
      t.string :title, null: false
      t.string :description

      t.references :user, foreign_key: true
      t.timestamps
    end

    create_table :images do |t|
      t.string :image_file, null: false

      t.references :user, foreign_key: true
      t.timestamps
    end

    create_table :images_galleries do |t|
      t.belongs_to :images, index: true, foreign_key: true
      t.belongs_to :galleries, index: true, foreign_key: true
    end
  end
end
