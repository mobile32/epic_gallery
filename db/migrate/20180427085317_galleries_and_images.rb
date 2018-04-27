class GalleriesAndImages < ActiveRecord::Migration[5.1]
  def change
    create_table :galleries do |t|
      t.string :cover_image
      t.string :title, null: false
      t.string :description

      t.references :user, foreign_key: true
      t.timestamps
    end

    create_table :uploads do |t|
      t.string :images, array: true, default: []

      t.references :user, foreign_key: true
      t.timestamps
    end

    create_table :uploads_galleries do |t|
      t.belongs_to :uploads, index: true, foreign_key: true
      t.belongs_to :galleries, index: true, foreign_key: true
    end
  end
end
